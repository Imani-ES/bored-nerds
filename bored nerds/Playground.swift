//
//  Playground.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/5/22.
//

import SwiftUI
import SwiftUICharts

struct Playground: View {
    @State var selection: String = sensor_list.accelerometer.name
    
    @State var chart_specs: chart_stuff = sensor_list.accelerometer.display()
    
    var body: some View {
        //Set up Timer: for ever 1 second, update sensor display values
        let _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if selection == sensor_list.accelerometer.name{
                chart_specs = sensor_list.accelerometer.display()
                
            }
            else if selection == sensor_list.gyroscope.name{
                chart_specs =  sensor_list.gyroscope.display()
                
            }
            
            else if selection == sensor_list.magnetometer.name{
                chart_specs =  sensor_list.magnetometer.display()
            }
            
            else if selection == sensor_list.pressure.name{
                chart_specs = sensor_list.pressure.display()
                
            }
            
            else if selection == sensor_list.proximity.name{
                chart_specs = sensor_list.proximity.display()
                
            }
        }
        
        VStack{
            title(data: "Playground")
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.proximityStateDidChangeNotification)) { _ in
                        sensor_list.proximity.update(data: UIDevice.current.proximityState ? [1.0] : [0.0])
                    }
            Picker(
                selection: $selection,
                label: Text("Choose Your sensor!"),
                content: {
                    Text(sensor_list.accelerometer.name).tag(sensor_list.accelerometer.name)
                    Text(sensor_list.gyroscope.name).tag(sensor_list.gyroscope.name)
                    Text(sensor_list.magnetometer.name).tag(sensor_list.magnetometer.name)
                    Text(sensor_list.pressure.name).tag(sensor_list.pressure.name)
                    Text(sensor_list.proximity.name).tag(sensor_list.proximity.name)
                }
            )
                    
            MultiLineChartView(
                data: chart_specs.chart_data,
                title: chart_specs.title,
                form: ChartForm.extraLarge,
                dropShadow: false
            )
            .padding(5)
        }.onAppear( perform: (sensor_list.begin_motion_sensing))
        
    }
    
}

struct Playground_Previews: PreviewProvider {
    static var previews: some View {
        Playground()
    }
}
