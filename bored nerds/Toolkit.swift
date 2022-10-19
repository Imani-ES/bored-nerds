//
//  Toolkit.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/11/22.
//

import Foundation
import Combine
import SwiftUI
import CoreMotion

//Sensor object that all sensors will be created from
class sensor: ObservableObject  {
    var didChange = PassthroughSubject<Void,Never>()
    
    let name :String
    let units:String
    let type :String
    let val_1_name: String
    let val_2_name: String
    let val_3_name: String
    var sensing: String = "False"{ didSet {didChange.send()}}
    
    @Published var out_1: [Double] = [0.0] { didSet {didChange.send()}}
    @Published var out_2: [Double] = [0.0] { didSet {didChange.send()}}
    @Published var out_3: [Double] = [0.0] { didSet {didChange.send()}}
    @Published var outs: [Double] = [0.0,0.0,0.0]
    
    init(name:String, units: String, type:String, val_1_name:String,val_2_name:String,val_3_name:String){
        self.name = name
        self.units = units
        self.type = type
        self.val_1_name = val_1_name
        self.val_2_name = val_2_name
        self.val_3_name = val_3_name
        print("Initialized " + name)
    }
    
    func start(sensor_availability:Bool) -> String{
        if sensor_availability == true{
            self.sensing = "True"
        }
        else{
            self.sensing = "False"
        }
        
        return self.sensing
    }
    
    func update(data:[Double]) {
        if data.count <= 1{
            self.outs = [data[0],0.0,0.0]
            if out_1.count > 60{
                out_1.removeFirst()
            }
        }
        else{
            self.outs = [data[0],data[1],data[2]]
            
            self.out_1.append(data[0])
            self.out_2.append(data[1])
            self.out_3.append(data[2])
            
            if out_1.count > 60{
                out_1.removeFirst()
            }
            
            if out_2.count > 60{
                out_2.removeFirst()
            }
            if out_3.count > 60{
                out_3.removeFirst()
            }
        }
        //return "Updated Successfully: \(self.name): \(self.show().description)"
    }
    
    func show() -> [String]{
        var ret : [String] = []
        ret.append("\(self.name)(\(self.units)):")
        ret.append(self.val_1_name == "" ? "" : "\(self.val_1_name): \(round(self.outs[0]*1000)/1000)")
        ret.append(self.val_2_name == "" ? "" : "\(self.val_2_name): \(round(self.outs[1]*1000)/1000)")
        ret.append(self.val_3_name == "" ? "" : "\(self.val_3_name): \(round(self.outs[2]*1000)/1000)")
        return ret
    }
    
    //Maybe have different class for movement sensors in future.
    //class movement_sensor: sensor { }
}

//display object used to keep track of user selected sensors
//class display: ObservableObject {
//    var didChange = PassthroughSubject<Void,Never>()
//
//    let name: String
//    var sensor_1: sensor{ didSet {didChange.send()}}
//    var sensor_2: sensor{ didSet {didChange.send()}}
//    var operation: Int{ didSet {didChange.send()}}
//
//    init(name:String, sensor_1:sensor, sensor_2: sensor, operation:Int){
//        self.name = name
//        self.sensor_1 = sensor_1
//        self.sensor_2 = sensor_2
//        self.operation = operation
//        print("Initialized " + name)
//    }
//
//    // Takes in sensor, attempts to add sensor to display.
//    // If display is full, return false error message, else return good.
//    func add_sensor(sensor:sensor) -> Int{
//        if self.sensor_1.name == "Comming Soon"{
//            self.sensor_1 = sensor
//            return 0
//        }
//        else if self.sensor_2.name == "Comming Soon"{
//            self.sensor_2 = sensor
//            return 0
//        }
//        return 1
//    }
//
//    // Takes in sensor, attempts to add sensor to display.
//    // If display is full, return false error message, else return good.
//    func remove_sensor(sensor:sensor) -> Int{
//        if self.sensor_1.name == sensor.name{
//            self.sensor_1 = dummy
//            return 0
//        }
//        else if self.sensor_2.name == sensor.name{
//            self.sensor_2 = dummy
//            return 0
//        }
//        return 1
//    }
//
//    //Output of display goes straight into graph in "Playground" sheet
//    func show() -> String{
//        let s_1: String = self.sensor_1.show()
//        //let s_2: [String] = self.sensor_2.show()
//        return s_1
//    }
//
//}

//default sensor
let dummy = sensor(name: "Comming Soon", units: "", type: "Comming Soon", val_1_name: "Comming Soon", val_2_name: "Comming Soon", val_3_name: "Comming Soon")

//Sensors object used to keep track of all sensors
class sensors: ObservableObject{
    var didChange = PassthroughSubject<Void,Never>()
    
    //Set up Motion Manager
    let motionmanager = CMMotionManager()
    let altimeter = CMAltimeter()
    let motion_queue = OperationQueue()
    let magnet_queue = OperationQueue()
    let pressure_queues = OperationQueue()
    let update_interval: Double
    
    //Set up sensors
    @Published var Dummy: sensor
    @Published var accelerometer: sensor
    @Published var gyroscope: sensor
    @Published var magnetometer: sensor
    @Published var pressure: sensor
    @Published var proximity: sensor
    
//    let Display: display
    
    init(update_interval: Double){
        
        self.update_interval = update_interval
        
        //default sensor
        self.Dummy = sensor(name: "Comming Soon", units: "",type: "Comming Soon", val_1_name: "Comming Soon", val_2_name: "Comming Soon", val_3_name: "Comming Soon")
        
        //Initialize sensors if they are available, else set to dummy
        self.accelerometer = self.motionmanager.isAccelerometerAvailable ?  sensor(name: "Accelerometer", units:"m/(s^2)", type: "move", val_1_name: "pitch", val_2_name: "yaw", val_3_name: "roll") : dummy
        
        self.gyroscope = self.motionmanager.isGyroAvailable ? sensor(name: "Gyroscope", units:"rad/s", type: "move", val_1_name: "x", val_2_name: "y", val_3_name: "z") : dummy
        
        self.magnetometer = self.motionmanager.isMagnetometerAvailable ? sensor(name: "Magnetometer", units:"(10^-6)Tesla", type: "move", val_1_name: "x", val_2_name: "y", val_3_name: "z") : dummy
        
//        self.Display = display(name: "display", sensor_1: dummy, sensor_2: dummy, operation: 0)
        
        self.pressure = CMAltimeter.isRelativeAltitudeAvailable() ? sensor(name: "Pressure", units: "kpa", type: "move", val_1_name: "pressure", val_2_name: "", val_3_name: "") : dummy
        
        self.proximity = sensor(name: "Proximity", units: "Bool", type: "Detect", val_1_name: "isClose", val_2_name: "", val_3_name: "")
        
        //Begin Sensing
        self.begin_motion_sensing()
    }
    
    //Fetch Sensor Data from device
    func begin_motion_sensing(){
        //set update intervals
        self.motionmanager.deviceMotionUpdateInterval = self.update_interval
        
        //Accelerometer and gyroscope updates
        self.motionmanager.startDeviceMotionUpdates(to: self.motion_queue){(data: CMDeviceMotion?, error: Error?) in
            let attitude: CMAttitude = data!.attitude
            let gyro: CMRotationRate = data!.rotationRate
            
            //Update sensor objects
            self.accelerometer.update(data: [attitude.pitch,attitude.yaw,attitude.roll])
            self.gyroscope.update(data: [gyro.x,gyro.y,gyro.z])
            
        }
        
        //Magnetic Field Updates
        self.motionmanager.startMagnetometerUpdates(to: self.magnet_queue){(data:CMMagnetometerData?, error:Error?) in
            let mag_field: CMMagneticField = data!.magneticField
            self.magnetometer.update(data: [mag_field.x,mag_field.y,mag_field.z])
            
        }
        
        //Pressure updates
        self.altimeter.startRelativeAltitudeUpdates(to:pressure_queues){(data:CMAltitudeData?, error:Error?) in
            self.pressure.update(data: [Double(truncating: data!.pressure)])
            
        }
        
        //Proximity Sensor
        UIDevice.current.isProximityMonitoringEnabled = true
            
        print("Now sensing motion")
    }
}

//sensor group object used by app
let sensor_list = sensors(update_interval: 0.1)

