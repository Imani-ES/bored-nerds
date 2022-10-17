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
    
    var out_1: [Double] = [0.0] { didSet {didChange.send()}}
    var out_2: [Double] = [0.0] { didSet {didChange.send()}}
    var out_3: [Double] = [0.0] { didSet {didChange.send()}}
    
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
    
    func update(data:[Double]) -> String {
        self.outs = [data[0],data[1],data[2]]
        
        self.out_1.append(data[0])        
        self.out_2.append(data[1])            
        self.out_3.append(data[2])
        
        if out_1.count > 60{
            self.outs = [out_1.removeFirst(),out_2.removeFirst(), out_3.removeFirst()]
            return "Updated Successfully: \(self.name): \(self.show().description)"
        }
        return "$"
    }
    
    func show() -> String{
        let nameandunits = "\(self.name)(\(self.units)):"
        let data = "\(["\(self.val_1_name): \(self.outs[0])","\(self.val_2_name): \(self.outs[1])","\(self.val_3_name): \(self.outs[2])"].description)"
        return "\(nameandunits) \(data)"
    }
    
    //Maybe have different class for movement sensors in future.
    //class movement_sensor: sensor { }
}

//display object used to keep track of user selected sensors
class display: ObservableObject {
    var didChange = PassthroughSubject<Void,Never>()
    
    let name: String
    var sensor_1: sensor{ didSet {didChange.send()}}
    var sensor_2: sensor{ didSet {didChange.send()}}
    var operation: Int{ didSet {didChange.send()}}
    
    init(name:String, sensor_1:sensor, sensor_2: sensor, operation:Int){
        self.name = name
        self.sensor_1 = sensor_1
        self.sensor_2 = sensor_2
        self.operation = operation
        print("Initialized " + name)
    }
    
    // Takes in sensor, attempts to add sensor to display.
    // If display is full, return false error message, else return good.
    func add_sensor(sensor:sensor) -> Int{
        if self.sensor_1.name == "Comming Soon"{
            self.sensor_1 = sensor
            return 0
        }
        else if self.sensor_2.name == "Comming Soon"{
            self.sensor_2 = sensor
            return 0
        }
        return 1
    }
    
    // Takes in sensor, attempts to add sensor to display.
    // If display is full, return false error message, else return good.
    func remove_sensor(sensor:sensor) -> Int{
        if self.sensor_1.name == sensor.name{
            self.sensor_1 = dummy
            return 0
        }
        else if self.sensor_2.name == sensor.name{
            self.sensor_2 = dummy
            return 0
        }
        return 1
    }
    
    //Output of display goes straight into graph in "Playground" sheet
    func show() -> String{
        let s_1: String = self.sensor_1.show()
        //let s_2: [String] = self.sensor_2.show()
        return s_1
    }
    
}

//default sensor
let dummy = sensor(name: "Comming Soon", units: "", type: "Comming Soon", val_1_name: "Comming Soon", val_2_name: "Comming Soon", val_3_name: "Comming Soon")

//Sensors object used to keep track of all sensors
class sensors: ObservableObject{
    var didChange = PassthroughSubject<Void,Never>()
    
    //Set up Motion Manager
    let motionmanager = CMMotionManager()
    let motion_queue = OperationQueue()
    let magnet_queue = OperationQueue()
    
    //Set up sensors
    @Published var Dummy: sensor
    @Published var accelerometer: sensor
    @Published var gyroscope: sensor
    @Published var magnetometer: sensor
    
    let Display: display
    
    init(){
        //default sensor
        self.Dummy = sensor(name: "Comming Soon", units: "",type: "Comming Soon", val_1_name: "Comming Soon", val_2_name: "Comming Soon", val_3_name: "Comming Soon")
        
        //Initialize sensors if they are available, else set to dummy
        self.accelerometer = motionmanager.isAccelerometerAvailable ?  sensor(name: "Accelerometer", units:"m/s^2", type: "move", val_1_name: "pitch", val_2_name: "yaw", val_3_name: "roll") : dummy
        
        self.gyroscope = motionmanager.isGyroAvailable ? sensor(name: "Gyroscope", units:"?", type: "move", val_1_name: "x", val_2_name: "y", val_3_name: "z") : dummy
        
        self.magnetometer = motionmanager.isMagnetometerAvailable ? sensor(name: "Magnetometer", units:"?", type: "move", val_1_name: "x", val_2_name: "y", val_3_name: "z") : dummy
        
        self.Display = display(name: "display", sensor_1: dummy, sensor_2: dummy, operation: 0)
        
        //Begin Sensing
        self.begin_motion_sensing()
    }
    
    //Fetch Sensor Data from device
    func begin_motion_sensing(){
        
        //Accelerometer and gyroscope updates
        self.motionmanager.startDeviceMotionUpdates(to: self.motion_queue){(data: CMDeviceMotion?, error: Error?) in
            let attitude: CMAttitude = data!.attitude
            let gyro: CMRotationRate = data!.rotationRate
            
            //Update sensor objects
            print(self.accelerometer.update(data: [attitude.pitch,attitude.yaw,attitude.roll]))
            print(self.gyroscope.update(data: [gyro.x,gyro.y,gyro.z]))
            
        }
        
        //Magnetic Field Updates
        self.motionmanager.startMagnetometerUpdates(to: self.magnet_queue){(data:CMMagnetometerData?, error:Error?) in
            let mag_field: CMMagneticField = data!.magneticField
            print(self.magnetometer.update(data: [mag_field.x,mag_field.y,mag_field.z]))
            
        }
        
        //Two more sensors here
        
        print("Now sensing motion")
    }
}

//sensor group object used by app
let sensor_list = sensors()

