//
//  About.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/5/22.
//

import SwiftUI

struct About: View {
    var body: some View {
        VStack{
            Text("The About page")
            Button("home"){
                
            }
        }
        Text(sensor_list.accelerometer.sensing)
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
