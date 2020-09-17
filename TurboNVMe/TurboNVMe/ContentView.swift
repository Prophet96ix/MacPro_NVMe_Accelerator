//
//  ContentView.swift
//  TurboNVMe
//
//  Created by Aaron Wagner on 17.09.20.
//  Copyright © 2020 Aaron Wagner. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            
            Text("TurboNVMe")
            
            Text("System Overview")
            Divider()
            
            
            List {
                VStack {
                    HStack {
                        Image(nsImage: NSImage(named: "NSStatusAvailable")!)
                            .renderingMode(.original)
                        Text("Samsung SSD 970 EVO 500GB")
                    }
                    Text("Speed: 1,437 Mb/s R/W");
                }
                VStack {
                    HStack {
                        Image(nsImage: NSImage(named: "NSStatusAvailable")!)
                            .renderingMode(.original)
                        Text("WD HDD Green 1TB")
                    }
                    Text("Speed: 1,437 Mb/s R/W");
                }
                HStack {
                    Image(nsImage: NSImage(named: "NSStatusAway")!)
                        .renderingMode(.original)
                    Text("SanDisk SSD 120GB")
                }
                HStack {
                    Image(nsImage: NSImage(named: "NSStatusPartiallyAvailable")!)
                        .renderingMode(.original)
                    Text("Crucial SSD MX500")
                }
            }
            
            
            
            // Diesen hier füllen
            VStack {
                Text("Status")
                HStack {
                    Image(nsImage: NSImage(named: "NSStatusAvailable")!)
                        .renderingMode(.original)
                    Image(nsImage: NSImage(named: "NSStatusAway")!)
                        .renderingMode(.original)
                    Image(nsImage: NSImage(named: "NSStatusPartiallyAvailable")!)
                        .renderingMode(.original)
                    Image(nsImage: NSImage(named: "NSStatusNone")!)
                        .renderingMode(.original)
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
