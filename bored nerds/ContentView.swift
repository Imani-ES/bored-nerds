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
    
    @State private var activepage: pages?
    
    var body: some View {
        VStack{
            Text("Hello, world!")
                .padding()
            
            Button("About Page"){
                activepage = ._about
            }
            Button("Settings"){
                activepage = ._settings
            }
            Button("Playground"){
                activepage = ._playground
            }
            
            Text(sensor_list.accelerometer.sensing)
            
            
            .onAppear{
                motionmanager.startDeviceMotionUpdates(to: motion_queue){(data: CMDeviceMotion?, error: Error?) in
                    let attitude: CMAttitude = data!.attitude
                    
                    print(sensor_list.accelerometer.update(data: [attitude.pitch,attitude.yaw,attitude.roll]))
                    
                }
            }
            
        }
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
    }
}
