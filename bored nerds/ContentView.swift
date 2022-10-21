//
//  ContentView.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/4/22.
//

import SwiftUI
import CoreMotion


//Create sheet links
enum pages: Identifiable{
    var id: Int {
        self.hashValue
    }
    case _about
    case _settings
    case _playground
}


struct ContentView: View {
    //@EnvironmentObject var sensor_list: sensors
    @State private var activepage: pages?
    
    var body: some View {
        VStack{
            Image("Bored_Nerds")
                .resizable()
                .scaledToFit()
                .padding(10)
                .cornerRadius(50)
                .frame(width: 300,height: 300)
            HStack{
                Button("About"){
                    activepage = ._about
                }
                Button("My Sensors"){
                    activepage = ._settings
                }.padding()
                Button("Playground"){
                    activepage = ._playground
                }
            }
                        
        }.onAppear( perform: (sensor_list.stop_motion_sensing))
        
        .environmentObject(sensor_list)
        
        .sheet(item: $activepage){item in
            switch item{
                case ._about:
                    About()
                case ._settings:
                    Settings()
                case ._playground:
                    Playground()
                }
                
            }
            
    }

    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.environmentObject(sensors())
    }
}
