//
//  About.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/5/22.
//

import SwiftUI

struct About: View {
    //@EnvironmentObject var sensor_list: sensors
    
    var body: some View {
        VStack{
            title(data: "About")
            Group{
                regular(data: "Bored Nerds is an app focused on educating bored nividuals about sensors on their phone...")
            }
            
            title(data: "Project Purpose")
            
            title(data: "About the Author")
            Group{
                sub_title(data: "Imani Muhammad-Graham")
                
                Image("imani_pic")
                    .resizable()
                    .cornerRadius(20)
                    .scaledToFit()
                regular(data: "")
                
                Image("black_ub_bull")
                    .resizable()
                    .cornerRadius(20)
                    .scaledToFit()
                
                
            }
            
            title(data: "Sources")
            Group{
                sub_title(data: "Apple Developer")
                regular(data: "Documentation for Device motion sensors accelerometer, gyroscope, magnetometer, and barometer")
                little(data: "https://developer.apple.com/documentation/coremotion/cmmotionmanager")
                regular(data: "Used for reference as to how to fetch, update, and display data")
                little(data: "https://www.youtube.com/watch?v=ARLy0rvyKz0")
                regular(data: "Used as a reference for learning Swift for backend processes")
                little(data: "https://www.youtube.com/watch?v=stSB04C4iS4")
                regular(data: "Used as a reference for learning Swift Views")
                little(data: "https://www.youtube.com/watch?v=uC3X4FoielU")
            }
            
        }
        Text(sensor_list.accelerometer.sensing)
    }
}

struct title: View{
    var data: String
    var body: some View{
        VStack{
            Text(data)
                .font(.title)
                .multilineTextAlignment(.center)
        }
    }
}

struct sub_title: View{
    var data: String
    var body: some View{
        VStack{
            Text(data)
                .font(.caption)
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
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
        }
    }
}

struct little: View{
    var data: String
    var body: some View{
        VStack{
            Text(data)
                .font(.footnote)
                .multilineTextAlignment(.leading)
        }
    }
}
struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
