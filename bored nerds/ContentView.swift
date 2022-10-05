//
//  ContentView.swift
//  bored nerds
//
//  Created by Muhammad-Graham, Imani on 10/4/22.
//

import SwiftUI

enum pages: Identifiable{
    var id: Int {
        self.hashValue
    }
    case page1
    case page2
    case page3
}
//CHEKING GIT
struct ContentView: View {
    
    @State private var activepage: pages?
    
    var body: some View {
        VStack{
            Text("Hello, world!")
                .padding()
            
            Button("Open page 1"){
                activepage = .page1
            }
            Button("Open page 2"){
                activepage = .page2
            }
            Button("Open page 3"){
                activepage = .page3
            }
            
            
            
        }
        .sheet(item: $activepage){item in
            switch item{
                case .page1:
                    Text("Hello, 1!")
                        .padding()
                    
                    Button("Open page 2"){
                        activepage = .page2
                    }
                case .page2:
                    Text("Hello, 2!")
                        .padding()
                    
                    Button("Open page 1"){
                        activepage = .page1
                    }
                case .page3:
                    Text("Hello, 3!")
                        .padding()
                    
                    Button("Open page 1"){
                        activepage = .page1
                    }
                }
                
            }
            
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
