//
//  Settings.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/5/22.
//

import SwiftUI

struct Settings: View {
    
    //Set up vars to hold sensor vals from timer
    @State var acc_data: _sensor_view = _sensor_view(sensor_data: ["Loading..."], sensor_title: "Comming Soon")
    @State var gyro_data: _sensor_view = _sensor_view(sensor_data: ["Loading..."], sensor_title: "Comming Soon")
    @State var press_data: _sensor_view = _sensor_view(sensor_data: ["Loading..."], sensor_title: "Comming Soon")
    @State var mag_data: _sensor_view = _sensor_view(sensor_data: ["Loading..."], sensor_title: "Comming Soon")
   
    @State var proximity    = "Loading..."
    @State var prox:Bool = false
    
    @State var acc_view = false
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
            acc_data =  _sensor_view(sensor_data: sensor_list.accelerometer.show_data(), sensor_title: sensor_list.accelerometer.show_title())
            gyro_data =  _sensor_view(sensor_data: sensor_list.gyroscope.show_data(), sensor_title: sensor_list.gyroscope.show_title())
            mag_data =  _sensor_view(sensor_data: sensor_list.magnetometer.show_data(), sensor_title: sensor_list.magnetometer.show_title())
            press_data =  _sensor_view(sensor_data: sensor_list.pressure.show_data(), sensor_title: sensor_list.pressure.show_title())
            
        }
        VStack{
            title(data: "Sensor Settings")
            ScrollView( content:{
                //Each sensor here
                VStack{
                    acc_data
                    gyro_data
                    mag_data
                    press_data
                    Text(proximity)
                }
            })
        }
    }
    
}
struct _sensor_view: View{
    let sensor_data: [String]
    let sensor_title: String
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
            
            Image("accelerometer_img")
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(20)
                .padding()
        }
    
    }
}


struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
