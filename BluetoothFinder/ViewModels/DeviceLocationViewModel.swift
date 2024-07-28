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
    
    func startHaptics() {
        hapticManager.performHapticFeedback(fromRSSI: device.rssi)
    }
    
    func stopHaptics() {
        hapticManager.stopHaptics()
    }
}
