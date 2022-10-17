//
//  Settings.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/5/22.
//

import SwiftUI

struct Settings: View {
   // @EnvironmentObject var sensor_list: sensors
    
    //Set up vars to hold sensor vals from timer
    @State var acc_data = "Loading..."
    @State var gyro_data = "Loading..."
    @State var mag_data = "Loading..."
    var body: some View {
        //Set up Timer
        //for ever 1 second, update sensor values
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            acc_data =  "\(String(sensor_list.accelerometer.name)) (m/s^2) \(sensor_list.accelerometer.outs.description)"
            gyro_data = " \(String(sensor_list.gyroscope.name)) (m/s^2) \(sensor_list.gyroscope.outs.description)"
            mag_data =  " \(String(sensor_list.magnetometer.name)) (m/s^2) \(sensor_list.magnetometer.outs.description)"
        }
        VStack{
            Text("Sensor Settings")
                .padding()
            
            Group {
                Text(acc_data)
                Text(gyro_data)
                Text(mag_data)
            }
            
        }
        
    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
