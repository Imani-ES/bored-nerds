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
            _about_section(data: "")
                .padding()
            
            _purpose(data: "")
                .padding()
            
            _about_the_author(data: "")
                .padding()
            
            _sources_section(data: "")
                .padding()
            
        }
    }
}

// Page sections
struct _purpose: View{
    var data: String
    var body: some View{
        VStack{
            title(data: "Project Purpose")
        }
    }
}

struct _about_section: View{
    var data: String
    var body: some View{
        VStack{
            title(data: "About")
            Group{
                regular(data: "Bored Nerds is an app focused on educating bored nividuals about sensors on their phone...")
            }
        }
    }
}

struct _about_the_author: View{
    var data: String
    var body: some View{
        VStack{
            title(data: "About the Author")
                .padding()
            Group{
                sub_title(data: "Imani Muhammad-Graham")
                
                Image("imani_pic")
                    .resizable()
                    .cornerRadius(20)
                    .scaledToFit()
                    
                regular(data: "")
                
                Image("ub_logo")
                    .resizable()
                    .cornerRadius(20)
                    .scaledToFit()
            }
        }
    }
}

struct _sources_section : View{
    var data: String
    var body: some View{
        VStack{
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
