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
            Group {
                if viewModel.devices.isEmpty {
                    Text("No devices found. Tap the Scan button to search for devices.")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.devices, id: \.id) { device in
                            NavigationLink(destination: DeviceLocationView(device: device)) {
                                HStack {
                                    Text(device.name)
                                    
                                    Spacer()
                                    
                                    Text("RSSI: \(device.rssi)")
                                }
                            }
                        }
                    }
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
