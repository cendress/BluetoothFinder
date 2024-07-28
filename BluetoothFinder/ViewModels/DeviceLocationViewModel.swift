//
//  DeviceLocationViewModel.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/28/24.
//

import SwiftUI

class DeviceLocationViewModel: ObservableObject {
    @Published var hapticManager = HapticManager()
    var device: BluetoothDevice
    
    init(device: BluetoothDevice) {
        self.device = device
    }
    
    var backgroundColor: Color {
        device.rssi > -60 ? .green : .red
    }
    
    func startHaptics() {
        hapticManager.performHapticFeedback(fromRSSI: device.rssi)
    }
    
    func stopHaptics() {
        hapticManager.stopHaptics()
    }
}
