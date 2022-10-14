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
    let type :String
    let val_1_name: String
    let val_2_name: String
    let val_3_name: String
    var sensing: String = "False"{ didSet {didChange.send()}}
    
    private var out_1: [Double] = [0.0] { didSet {didChange.send()}}
    private var out_2: [Double] = [0.0] { didSet {didChange.send()}}
    private var out_3: [Double] = [0.0] { didSet {didChange.send()}}
    
    init(name:String, type:String, val_1_name:String,val_2_name:String,val_3_name:String){
        self.name = name
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
        self.out_1.append(data[0])
        self.out_2.append(data[1])
        self.out_3.append(data[2])
        return "Updated Successfully"
    }
    
    func show() -> [Double]{
        return [out_1.last ?? 0.0, out_2.last ?? 0.0, out_3.last ?? 0.0]
    }
    //Maybe have different class for movement sensors in future.
    //class movement_sensor: sensor { }
}

//default sensor
let dummy = sensor(name: "Dummy", type: "Dumb", val_1_name: "Dumb", val_2_name: "Dumb", val_3_name: "Dumb")

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
        if self.sensor_1.name == "Dummy"{
            self.sensor_1 = sensor
            return 0
        }
        else if self.sensor_2.name == "Dummy"{
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
    func show() -> [Double]{
        let s_1: [Double] = self.sensor_1.show()
        let s_2: [Double] = self.sensor_2.show()
        if operation == 0{
            return [s_1[0],s_1[1],s_1[2]]
        }
        
        else if operation == 1{
            return [s_1[0] + s_2[0],s_1[1] + s_2[1],s_1[2] + s_2[2]]
        }
        return [0.0]
    }
    
}

//Sensors object used to keep track of all sensors
class sensors{
    var didChange = PassthroughSubject<Void,Never>()
    
    //Set up Motion Manager
    let motionmanager = CMMotionManager()
    let motion_queue = OperationQueue()

    
    //Set up sensors
    let Dummy: sensor = dummy
    let accelerometer: sensor
    let gyroscope: sensor
    let magnetometer: sensor
    
    let Display: display
    
    init(){
        //Initialize sensors
        self.accelerometer = sensor(name: "Accelerometer", type: "move", val_1_name: "pitch", val_2_name: "yaw", val_3_name: "roll")
        
        self.Display = display(name: "display", sensor_1: Dummy, sensor_2: Dummy, operation: 0)
        
        self.gyroscope = sensor(name: "Gyroscope", type: "move", val_1_name: "x", val_2_name: "y", val_3_name: "z")
        
        self.magnetometer = sensor(name: "Magnetometer", type: "move", val_1_name: "x", val_2_name: "y", val_3_name: "z")
        
        //Begin Sensing
        self.begin_motion_sensing()
    }
    
    //Fetch Sensor Data from device
    func begin_motion_sensing(){
        self.motionmanager.startDeviceMotionUpdates(to: self.motion_queue){(data: CMDeviceMotion?, error: Error?) in
            let attitude: CMAttitude = data!.attitude
            let gyro: CMRotationRate = data!.rotationRate
            let mag_field: CMMagneticField = data!.magneticField.field
            
            //Update sensor objects
            print(self.accelerometer.update(data: [attitude.pitch,attitude.yaw,attitude.roll]))
            print(self.gyroscope.update(data: [gyro.x,gyro.y,gyro.z]))
            print(self.magnetometer.update(data: [mag_field.x,mag_field.y,mag_field.z]))
        }
        print("Now sensing motion")
    }
}

//sensor group object used by app
let sensor_list = sensors()

