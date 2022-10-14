//
//  Settings.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/5/22.
//

import SwiftUI

struct Settings: View {
    @State var accel_data = sensor_list.accelerometer
    @State var gyro_data = sensor_list.gyroscope
    @State var mag_data = sensor_list.magnetometer
    var body: some View {
        
        VStack{
            Text("Sensor Settings")
                .padding()
            
            Group {
                Text("Accelerometer:")
                Text(accel_data.val_1_name + ":" + String(accel_data.show()[0]))
                Text(accel_data.val_2_name + ":" + String(accel_data.show()[1]))
                Text(accel_data.val_3_name + ":" + String(accel_data.show()[2]))
//
                Text("Gyroscope:")
//                Text(gyro_data.val_1_name + ":" + String(gyro_data.show()[0]))
//                Text(gyro_data.val_2_name + ":" + String(gyro_data.show()[1]))
//                Text(gyro_data.val_3_name + ":" + String(gyro_data.show()[2]))
//
                Text("Magnetometer:")
//                Text(mag_data.val_1_name + ":" + String(mag_data.show()[0]))
//                Text(mag_data.val_2_name + ":" + String(mag_data.show()[1]))
//                Text(mag_data.val_3_name + ":" + String(mag_data.show()[2]))
            }
            
        }
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
