//
//  DeviceLocationViewModel.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/28/24.
//

import SwiftUI

class DeviceLocationViewModel: ObservableObject {
    @Published var device: BluetoothDevice
    var hapticManager = HapticManager()
    
    init(device: BluetoothDevice) {
        self.device = device
    }
    
    var proximityMessage: String {
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
