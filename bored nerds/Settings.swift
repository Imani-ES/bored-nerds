//
//  Settings.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/5/22.
//

import SwiftUI

struct Settings: View {
    
    //Set up vars to hold sensor vals from timer
    @State var acc_data: _sensor_view = _sensor_view(sensor_data: ["Loading..."], sensor_title: sensor_list.accelerometer.show_title(), img: sensor_list.accelerometer.img)
    
    @State var gyro_data: _sensor_view = _sensor_view(sensor_data: ["Loading..."], sensor_title: sensor_list.gyroscope.show_title(), img: sensor_list.gyroscope.img)
    
    @State var press_data: _sensor_view = _sensor_view(sensor_data: ["Loading..."], sensor_title: sensor_list.pressure.show_title(), img: sensor_list.pressure.img)
    
    @State var mag_data: _sensor_view = _sensor_view(sensor_data: ["Loading..."], sensor_title: sensor_list.magnetometer.show_title(), img: sensor_list.magnetometer.img)
    
    @State var prox_data: _sensor_view  = _sensor_view(sensor_data: ["Loading..."], sensor_title: sensor_list.proximity.show_title(), img: sensor_list.proximity.img)
    
    var body: some View {
        //Set up Timer: for ever 1 second, update sensor values
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            //Update
                
            prox_data.sensor_data = sensor_list.proximity.show_data()
            
            acc_data.sensor_data =  sensor_list.accelerometer.show_data()
            
            gyro_data.sensor_data =  sensor_list.gyroscope.show_data()
            
            mag_data.sensor_data = sensor_list.magnetometer.show_data()
            
            press_data.sensor_data = sensor_list.pressure.show_data()
            
        }
        
        
        VStack{
            title(data: "Sensor Data")
                .padding()
            //Each sensor here
            acc_data
            Divider()
            gyro_data
            Divider()
            mag_data
            Divider()
            press_data
            Divider()
            prox_data
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.proximityStateDidChangeNotification)) { _ in
                        sensor_list.proximity.update(data: UIDevice.current.proximityState ? [1.0] : [0.0])
                    }
            
        }.onAppear( perform: (sensor_list.begin_motion_sensing))
        
    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
