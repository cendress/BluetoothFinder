//
//  BluetoothDevice.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import Foundation
import Combine

class BluetoothDevice: Identifiable, ObservableObject {
    // Use the device's name as the unique identifier
    var id: String { name }
    @Published var name: String
    @Published var rssi: Int
    // TX power might not be available for all devices
    @Published var txPower: Int?
    
    init(name: String, rssi: Int, txPower: Int?) {
        self.name = name
        self.rssi = rssi
        self.txPower = txPower
    }
}
