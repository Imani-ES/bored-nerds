//
//  Toolkit.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/11/22.
//

import Foundation
import Combine

//Used in Settings and Playground Sheet
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

let Dummy = sensor(name: "Dummy", outputs: 1)
let Accel = sensor(name: "Accelerometer", outputs: 3)
let Gyros = sensor(name: "Gyroscope", outputs: 2)

//Used in Playground Sheet
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
        self.sensor_1 = Dummy
        self.sensor_2 = Dummy
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
