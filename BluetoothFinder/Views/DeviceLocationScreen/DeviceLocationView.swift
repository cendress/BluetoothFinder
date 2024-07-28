//
//  DeviceLocationView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import CoreHaptics
import SwiftUI

struct DeviceLocationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: DeviceLocationViewModel
    
    var device: BluetoothDevice
    
    private var backgroundColor: Color {
        device.rssi > -60 ? .green : .red
    }
    
    init(device: BluetoothDevice) {
        self.device = device
        _viewModel = StateObject(wrappedValue: DeviceLocationViewModel(device: device))
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                ProximityCircleView(rssi: device.rssi, geometry: geometry)
                
                Spacer()
                
                ProximityMessageView(device: device)
                
                DistanceInformationView(device: device)
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            .onAppear(perform: viewModel.startHaptics)
            .onDisappear(perform: viewModel.stopHaptics)
        }
        .background(backgroundColor)
        .navigationTitle("Device Location")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

//#Preview {
//    let sampleDevice = BluetoothDevice(id: UUID(), name: "Router", rssi: 0, txPower: nil)
//    
//    return DeviceLocationView(viewModel: DeviceLocationViewModel(device: sampleDevice), device: sampleDevice)
//}
