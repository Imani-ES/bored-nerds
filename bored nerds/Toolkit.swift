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
import SwiftUICharts

//Sensor object that all sensors will be created from
class sensor: ObservableObject  {
    var didChange = PassthroughSubject<Void,Never>()
    
    let name :String
    let units:String
    let img: String
    let type :String
    let val_1_name: String
    let val_2_name: String
    let val_3_name: String
    var sensing: String = "False"{ didSet {didChange.send()}}
    
    @Published var out_1: [Double] = [0.0] { didSet {didChange.send()}}
    @Published var out_2: [Double] = [0.0] { didSet {didChange.send()}}
    @Published var out_3: [Double] = [0.0] { didSet {didChange.send()}}
    @Published var outs: [Double] = [0.0,0.0,0.0]
    
    init(name:String, units: String, type:String, val_1_name:String,val_2_name:String,val_3_name:String, img:String){
        self.name = name
        self.units = units
        self.type = type
        self.val_1_name = val_1_name
        self.val_2_name = val_2_name
        self.val_3_name = val_3_name
        self.img = img
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

    }
  
    func show_title() -> String{
        return "\(self.name)(\(self.units))"
    }
  
    func show_data() -> [String]{
        var ret : [String] = []
        ret.append(self.val_1_name == "" ? "" : "\(self.val_1_name): \(round(self.outs[0]*1000)/1000)")
        ret.append(self.val_2_name == "" ? "" : "\(self.val_2_name): \(round(self.outs[1]*1000)/1000)")
        ret.append(self.val_3_name == "" ? "" : "\(self.val_3_name): \(round(self.outs[2]*1000)/1000)")
        return ret
    }
    
    func display() -> chart_stuff {
        return chart_stuff(chart_data: [(self.out_1,GradientColors.blue),(self.out_2,GradientColors.orngPink),(self.out_3,GradientColors.green)], title: self.name)
    }
    
}

//default sensor
let dummy = sensor(name: "Comming Soon", units: "", type: "Comming Soon", val_1_name: "Comming Soon", val_2_name: "Comming Soon", val_3_name: "Comming Soon",img: "")

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
        self.Dummy = sensor(name: "Comming Soon", units: "",type: "Comming Soon", val_1_name: "Comming Soon", val_2_name: "Comming Soon", val_3_name: "Comming Soon",img:"")
        
        //Initialize sensors if they are available, else set to dummy
        self.accelerometer = self.motionmanager.isAccelerometerAvailable ?  sensor(name: "Accelerometer", units:"m/(s^2)", type: "move", val_1_name: "pitch", val_2_name: "yaw", val_3_name: "roll",img: "accelerometer_img") : dummy
        
        self.gyroscope = self.motionmanager.isGyroAvailable ? sensor(name: "Gyroscope", units:"rad/s", type: "move", val_1_name: "x", val_2_name: "y", val_3_name: "z",img: "Gyro") : dummy
        
        self.magnetometer = self.motionmanager.isMagnetometerAvailable ? sensor(name: "Magnetometer", units:"(10^-6)T", type: "move", val_1_name: "x", val_2_name: "y", val_3_name: "z",img: "Magnet") : dummy
         
        self.pressure = CMAltimeter.isRelativeAltitudeAvailable() ? sensor(name: "Pressure", units: "kpa", type: "move", val_1_name: "pressure", val_2_name: "", val_3_name: "",img: "Pressure") : dummy
        
        self.proximity = sensor(name: "Proximity", units: "Bool", type: "Detect", val_1_name: "isClose", val_2_name: "", val_3_name: "",img: "Loading")
        
        //Begin Sensing
        //self.begin_motion_sensing()
    }
    
    //Fetch Sensor Data from device
    func begin_motion_sensing() -> Void{
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
    
    //Need stop motion sensing
    func stop_motion_sensing() -> Void{
        
        //Stop Accelerometer and gyroscope updates
        self.motionmanager.stopDeviceMotionUpdates()
        
        //Stop Magnetic Field Updates
        self.motionmanager.stopMagnetometerUpdates()
        
        //Stop Pressure updates
        self.altimeter.stopRelativeAltitudeUpdates()
        
        //Proximity Sensor
        UIDevice.current.isProximityMonitoringEnabled = false
    }
}

//sensor group object used by app
let sensor_list = sensors(update_interval: 0.1)

//Display Elements
struct chart_stuff {
    var chart_data: [([Double],GradientColor)]
    var title: String
    
}

struct _sensor_view: View{
    var sensor_data: [String]
    let sensor_title: String
    let img: String
    var body: some View{
        HStack{
            Menu {
                ForEach(0..<3){ i in
                    if i < sensor_data.count{
                        regular(data: sensor_data[i])
                    }
                }
            } label: {
                sub_title(data: sensor_title)
            }
            
            Image(self.img)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(20)
                .padding()
        }
    
    }
}



// Page sections
struct _purpose: View{
    var data: String
    var body: some View{
        VStack{
            sub_title(data: "Project Purpose")
            little(data: "Bored Nerds is an app focused on educating bored individuals about sensors on their phone...")
        }
    }
}

struct _about_section: View{
    var data: String
    var body: some View{
        VStack{
            title(data: "About")
        }
    }
}

struct _about_the_author: View{
    var data: String
    var body: some View{
        sub_title(data: "About the Author")
        regular(data: "Imani Muhammad-Graham")
        HStack{
            Image("imani_pic")
                .resizable()
                .cornerRadius(20)
                .scaledToFit()
                .padding()
            
            Image("ub_bull")
                .resizable()
                .frame(width: 75.0,height: 75.0)
                .cornerRadius(20)
                .scaledToFit()
                .padding()
        }
        Divider()
        sub_title(data: "Code")
        Link("Github", destination: URL(string: "https://github.com/Imani-ES/bored-nerds")!)
        sub_title(data: "Connect")
        Link("Linkedin", destination: URL(string:"https://www.linkedin.com/in/imani-muhammad-graham-424b4a127")!)
        
    }
}

struct _sources_section : View{
    var data: String
    var body: some View{
        sub_title(data: "Sources")
        ScrollView(.vertical, showsIndicators: true, content:{
            VStack{
                regular(data: "Apple Developer")
                Link("Device Motion Sensors", destination: URL (string:  "https://developer.apple.com/documentation/coremotion/cmmotionmanager")!)
                
                regular(data: "Youtube/ Tutorials")
                Link("Swift Programming", destination: URL(string: "https://www.youtube.com/watch?v=stSB04C4iS4")!)
                Link("Swift Views", destination: URL (string:"https://www.youtube.com/watch?v=uC3X4FoielU")!)
                Link("SwiftUI Charts", destination: URL(string: "https://www.youtube.com/watch?v=ARLy0rvyKz0")!)
                
                
            }
        })
        
    }
}

// Text Types
struct title: View{
    var data: String
    var body: some View{
        VStack{
            Text(data)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct sub_title: View{
    var data: String
    var body: some View{
        VStack{
            Text(data)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
                .padding()
        }
    }
}

struct regular:View{
    var data: String
    var body: some View{
        VStack{
            Text(data)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding()
        }
    }
}

struct little: View{
    var data: String
    var body: some View{
        VStack{
            Text(data)
                .font(.caption2)
                .multilineTextAlignment(.leading)
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
