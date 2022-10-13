//
//  Toolkit.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/11/22.
//

import Foundation
import Combine
import SwiftUI

class sensor: ObservableObject  {
    var didChange = PassthroughSubject<Void,Never>()
    
    let name :String
    let out_1_name: String
    let out_2_name: String
    let out_3_name: String
    
    var sensing: String = "False"
    private var out_1: [Double] = [0.0] { didSet {didChange.send()}}
    private var out_2: [Double] = [0.0] { didSet {didChange.send()}}
    private var out_3: [Double] = [0.0] { didSet {didChange.send()}}
    
    init(name:String, out_1_name:String, out_2_name:String,out_3_name:String){
        self.name = name
        self.out_1_name = out_1_name
        self.out_2_name = out_2_name
        self.out_3_name = out_3_name
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
    
}

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
    }
    
    // Takes in sensor, attempts to add sensor to display.
    // If display is full, return false error message, else return good.
    func add_sensor(sensor:sensor) -> Int{
        if self.sensor_1.name == "Dummy"{
            self.sensor_1 = sensor
            return 0
        }
        else if self.sensor_2.name == "Dummy" && self.sensor_1.name != "Accelerometer"{
            self.sensor_2 = sensor
            return 0
        }
        return 1
    }
    
    // Takes in sensor, attempts to add sensor to display.
    // If display is full, return false error message, else return good.
    func remove_sensor(sensor:sensor) -> Int{
        if self.sensor_1 == sensor{
            self.sensor_1 = Dummy
            return 0
        }
        else if self.sensor_2.name == sensor{
            self.sensor_2 = Dummy
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

class sensors{
    var didChange = PassthroughSubject<Void,Never>()
    
    let accelerometer: sensor
    let Dummy: sensor
    let Display: display
    
    init(){
        self.accelerometer = sensor(name: "Accelerometer", out_1_name: "Pitch", out_2_name: "Yaw", out_3_name: "Roll")
        
        self.Dummy = sensor(name: "Dummy", out_1_name: "Dumb", out_2_name: "Dumb", out_3_name: "Dumb")
        
        self.Display = display(name: "display", sensor_1: Dummy, sensor_2: Dummy, operation: 0)
    }
}

let sensor_list = sensors()
