//
//  DeviceListView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import SwiftUI

struct DeviceListView: View {
    @StateObject var viewModel: DeviceListViewModel
    
    var body: some View {
        Group {
            if viewModel.devices.isEmpty {
                EmptyDeviceView()
            } else {
                DeviceList(devices: viewModel.devices)
            }
        }
        .toolbar {
            Button("Scan", systemImage: "antenna.radiowaves.left.and.right") {
                viewModel.startScanning()
            }
        }
        .navigationTitle("Nearby Devices")
    }
}

#Preview {
    DeviceListView(viewModel: DeviceListViewModel())
}
