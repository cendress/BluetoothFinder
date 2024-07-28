//
//  DeviceList.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/28/24.
//

import SwiftUI

struct DeviceList: View {
    var devices: [BluetoothDevice]
    
    var body: some View {
        List(devices, id: \.id) { device in
            NavigationLink(destination: DeviceLocationView(device: device)) {
                DeviceRowView(device: device)
            }
        }
    }
}
