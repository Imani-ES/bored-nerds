//
//  Settings.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/5/22.
//

import SwiftUI

struct Settings: View {
    @State var accel_data = sensor_list.accelerometer.show()
    var body: some View {
        VStack{
            Text("Settings")
            Text("Accelerometer:")
            Text(sensor_list.accelerometer.val_1_name + ":" + String(accel_data[0]))
            Text(sensor_list.accelerometer.val_2_name + ":" + String(accel_data[1]))
            Text(sensor_list.accelerometer.val_3_name + ":" + String(accel_data[2]))
        }
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
