//
//  Playground.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/5/22.
//

import SwiftUI
import SwiftUICharts

struct Playground: View {
    @State var chart_data = [([0.0],GradientColors.blue)]
    var body: some View {
        let _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            chart_data = [(sensor_list.accelerometer.out_1,GradientColors.blue)]
        }
        VStack{
            Text("Playground")
            MultiLineChartView(
                data: chart_data,
                title: "Accelerometer x",
                form: ChartForm.extraLarge,
                dropShadow: false
            )
        }
        
    }
    
}
    

struct Playground_Previews: PreviewProvider {
    static var previews: some View {
        Playground()
    }
}
