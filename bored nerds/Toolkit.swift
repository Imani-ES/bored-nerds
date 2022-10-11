//
//  Toolkit.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/11/22.
//

import Foundation
import Combine

class sensor {
    var didChange = PassthroughSubject<Void,Never>()
    
    let name :String
    let outputs: Int
    
    var sensing: String = "False"
    var out_1: [Double] = [0.0]
    var out_2: [Double] = [0.0]
    var out_3: [Double] = [0.0]
    
    init(name:String,outputs:Int){
        self.name = name
        self.outputs = outputs
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
    
    func update()
}

class display{
    var didChange = PassthroughSubject<Void,Never>()
    let name: String
    var sensor_1: sensor
    var sensor_2: sensor
    var operation: Int = 0
    
    var out_1: Double = 0.0
    var out_2: Double = 0.0
    var out_3: Double = 0.0
    
    init(name:String, sensor_1:sensor, sensor_2: sensor, operation:Int){
        self.name = name
        self.sensor_1 = sensor_1
        self.sensor_2 = sensor_2
        self.operation = operation
    }
    func add_sensor(sensor:sensor) -> Int{
//        Takes in sensor, attempts to add sensor to display.
//        If display is full, return false error message, else return good.
        
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
    func show(){
        if operation == 0{
            out_1 = sensor_1.out_1.last + sensor_2.out_1.last
            out_2 = sensor_1.out_2.last + sensor_2.out_2.last
            out_3 = sensor_1.out_3.last + sensor_2.out_3.last
        }
                
        
        
    }
}
