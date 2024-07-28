//
//  DeviceRow.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/28/24.
//

import SwiftUI

struct DeviceRow: View {
    var device: BluetoothDevice
    
    var body: some View {
        HStack {
            Text(device.name)
            
            Spacer()
            
            Text("RSSI: \(device.rssi)")
        }
    }
}

#Preview {
    let sampleDevice = BluetoothDevice(name: "Personal Computer", rssi: -30, txPower: nil)
    
    return DeviceRow(device: sampleDevice)
}
