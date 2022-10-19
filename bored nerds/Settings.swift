//
//  Settings.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/5/22.
//

import SwiftUI

struct Settings: View {
    
    //Set up vars to hold sensor vals from timer
    @State var acc_data     = "Loading..."
    @State var gyro_data    = "Loading..."
    @State var mag_data     = "Loading..."
    @State var press_data   = "Loading..."
    @State var proximity    = "Loading..."
    @State var prox:Bool = false
    
    var body: some View {
        
        //Set up Timer: for ever 1 second, update sensor values
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            //set up proximity updates
            if UIDevice.current.proximityState {
                prox = !prox
                proximity = "Back up !!" //sensor_list.proximity.update(data: [Double(prox_cnt)])
            }
            else{
                proximity = "Welcome"
            }
            //other updates
            acc_data =  "\(String(sensor_list.accelerometer.show().description))"
            gyro_data = "\(String(sensor_list.gyroscope.show().description))"
            mag_data =  "\(String(sensor_list.magnetometer.show().description))"
            press_data = "\(String(sensor_list.pressure.show().description))"
        }
        
        VStack{
            Text("Sensor Settings")
                .padding()
            
            Group {
                Text(acc_data)
                Text(gyro_data)
                Text(mag_data)
                Text(press_data)
                Text(proximity)
            }
        }        
    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
