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

