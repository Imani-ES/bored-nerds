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
                
                Divider()
                _purpose(data: "")
                
                Divider()
                _sources_section(data: "")
                
                Divider()
                _about_the_author(data: "")
            }
            
        })
    }
}

// Page sections
struct _purpose: View{
    var data: String
    var body: some View{
        VStack{
            sub_title(data: "Project Purpose")
            little(data: "Bored Nerds is an app focused on educating bored individuals about sensors on their phone...")
        }
    }
}

struct _about_section: View{
    var data: String
    var body: some View{
        VStack{
            title(data: "About")
        }
    }
}

struct _about_the_author: View{
    var data: String
    var body: some View{
        sub_title(data: "About the Author")
        regular(data: "Imani Muhammad-Graham")
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
        Divider()
        sub_title(data: "Connect")
        Link("Linkedin", destination: URL(string:"https://www.linkedin.com/in/imani-muhammad-graham-424b4a127")!)
        
    }
}

struct _sources_section : View{
    var data: String
    var body: some View{
        sub_title(data: "Sources")
        ScrollView(.vertical, showsIndicators: true, content:{
            VStack{
                regular(data: "Apple Developer")
                Link("Device Motion Sensors", destination: URL (string:  "https://developer.apple.com/documentation/coremotion/cmmotionmanager")!)
                
                regular(data: "Youtube/ Tutorials")
                Link("Swift Programming", destination: URL(string: "https://www.youtube.com/watch?v=stSB04C4iS4")!)
                Link("Swift Views", destination: URL (string:"https://www.youtube.com/watch?v=uC3X4FoielU")!)
                Link("SwiftUI Charts", destination: URL(string: "https://www.youtube.com/watch?v=ARLy0rvyKz0")!)
                
                
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
                .padding()
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
