//
//  ProximityMessageView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/28/24.
//

import SwiftUI

struct ProximityMessageView: View {
    var device: BluetoothDevice
    
    var body: some View {
        Text(proximityMessage)
            .font(.title)
            .fontWeight(.bold)
            .padding()
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.5), value: proximityMessage)
    }
    
    private var proximityMessage: String {
        switch device.rssi {
        case -40...0:
            return "You're very close!"
        case -60..<(-40):
            return "Getting closer..."
        case -80..<(-60):
            return "Still far away..."
        default:
            return "Very far away..."
        }
    }
}
