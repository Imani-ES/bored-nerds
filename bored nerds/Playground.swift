//
//  Playground.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/5/22.
//

import SwiftUI
//maybe chartview: https://github.com/AppPear/ChartView.git

struct Playground: View {
    @EnvironmentObject var sensor_list: sensors
    
    var body: some View {
        VStack{
            Text("Playground")
        }
        Text(sensor_list.accelerometer.sensing)
        .onAppear{
            //get motion manager going
            //self.motionManager.startDeviceMotionUpdates(to: self.queue){ (data: CMDeviceMotion?, error: Error?) in
                //set up each
                
                
            }
    }
    
    }
    

struct Playground_Previews: PreviewProvider {
    static var previews: some View {
        Playground()
    }
}
