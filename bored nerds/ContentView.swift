//
//  ContentView.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/4/22.
//

import SwiftUI
import CoreMotion

let motionManager = CMMotionManager()

enum pages: Identifiable{
    var id: Int {
        self.hashValue
    }
    case _about
    case _settings
    case _playground
}
//CHEKING GIT
struct ContentView: View {
    
    @State private var activepage: pages?
    
    var body: some View {
        VStack{
            Text("Hello, world!")
                .padding()
            
            Button("Open page 1"){
                activepage = ._about
            }
            Button("Open page 2"){
                activepage = ._settings
            }
            Button("Open page 3"){
                activepage = ._playground
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
