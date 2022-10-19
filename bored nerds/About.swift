//
//  About.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/5/22.
//

import SwiftUI

struct About: View {
    
    var body: some View {
        ScrollView(content: {
            VStack{
                _about_section(data: "")
                    .padding(.vertical)
                
                _purpose(data: "")
                    .padding(.vertical)
                                        
                _sources_section(data: "")
                    .padding(.vertical)
                
                _about_the_author(data: "")
                    .padding(.vertical)
            }
            
        })
    }
}

// Page sections
struct _purpose: View{
    var data: String
    var body: some View{
        VStack{
            title(data: "Project Purpose")
            regular(data: "Bored Nerds is an app focused on educating bored individuals about sensors on their phone...")
        }
    }
}

struct _about_section: View{
    var data: String
    var body: some View{
        VStack{
            title(data: "About")
            regular(data: "An intro to the app...")
        }
    }
}

struct _about_the_author: View{
    var data: String
    var body: some View{
        title(data: "About the Author")
        sub_title(data: "Imani Muhammad-Graham")
        HStack{
            Image("imani_pic")
                .resizable()
                .cornerRadius(20)
                .scaledToFit()
                .padding()
            
            Image("ub_bull")
                .resizable()
                .frame(width: 75.0,height: 75.0)
                .cornerRadius(20)
                .scaledToFit()
                .padding()
        }
        sub_title(data: "Connect")
        
    }
}

struct _sources_section : View{
    var data: String
    var body: some View{
        title(data: "Sources")
        ScrollView(.vertical, showsIndicators: true, content:{
            VStack{
                Group{
                    sub_title(data: "Apple Developer")
                    regular(data: "Documentation for Device motion sensors accelerometer, gyroscope, magnetometer, and barometer")
                    little(data: "https://developer.apple.com/documentation/coremotion/cmmotionmanager")
                    
                    sub_title(data: "Youtube/ Tutorials")
                    regular(data: "Used for reference as to how to fetch, update, and display data")
                    little(data: "https://www.youtube.com/watch?v=ARLy0rvyKz0")
                    regular(data: "Used as a reference for learning Swift for backend processes")
                    little(data: "https://www.youtube.com/watch?v=stSB04C4iS4")
                    regular(data: "Used as a reference for learning Swift Views")
                    little(data: "https://www.youtube.com/watch?v=uC3X4FoielU")
                }
            }
        })
        
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
                .padding()
        }
    }
}

struct sub_title: View{
    var data: String
    var body: some View{
        VStack{
            Text(data)
                .font(.title2)
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
                .padding()
        }
    }
}

struct little: View{
    var data: String
    var body: some View{
        VStack{
            Text(data)
                .font(.caption2)
                .multilineTextAlignment(.leading)
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
