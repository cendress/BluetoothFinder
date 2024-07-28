//
//  DeviceRow.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/28/24.
//

import SwiftUI

struct DeviceRowView: View {
    var device: BluetoothDevice
    
    var body: some View {
        HStack {
            Image(systemName: "dot.radiowaves.left.and.right")
                .foregroundColor(.blue)
                .padding(.trailing, 8)
            
            Text(device.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text("RSSI: \(device.rssi)")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.leading, 8)
        }
        .padding()
    }
}

#Preview {
    let sampleDevice = BluetoothDevice(id: UUID(), name: "Personal Computer", rssi: -30, txPower: nil)
    
    return DeviceRowView(device: sampleDevice)
}
