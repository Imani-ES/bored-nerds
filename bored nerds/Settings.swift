//
//  Settings.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/5/22.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var sensor_list: sensors
    
    //Set up vars to hold sensor vals from timer
    @State acc_data: String = "Loading..."
    
    var body: some View {
        
        VStack{
            Text("Sensor Settings")
                .padding()
            
            Group {
                Text("Accelerometer:")
                Text(sensor_list.accelerometer.name + ":" + String(sensor_list.accelerometer.outs))
                //Output vars with timer data
                Text(acc_data)
            }
            
        }
        
        //Set up Timer
        //for ever 1 second, update sensor values
        Timer.scheduledTimer(withTimeInterval: 1, repeats: True) _ in{
            acc_data ="""
            Accelerometer (m/s^2)
            \(sensor_list.accelerometer.name) + ":" + \(String(sensor_list.accelerometer.outs))
            """
            
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
