//
//  DeviceListView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import SwiftUI

struct DeviceListView: View {
    @ObservedObject var viewModel: DeviceListViewModel
    
    var body: some View {
            List(viewModel.devices) { device in
                HStack {
                    Text(device.name)
                    Spacer()
                    Text("RSSI: \(device.rssi)")
                }
            }
            .navigationTitle("Nearby Devices")
    }
}

#Preview {
    DeviceListView(viewModel: DeviceListViewModel())
}
