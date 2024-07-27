//
//  DeviceLocationView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import Foundation
import SwiftUI

struct DeviceLocationView: View {
    let device: BluetoothDevice
    
    var body: some View {
        Text("Locating \(device.name)")
            .navigationTitle("Device Location")
    }
}
