//
//  BluetoothDevice.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import Foundation

@Observable
class BluetoothDevice: Identifiable {
    // Use the device's name as the unique identifier
    var id: String { name }
    let name: String
    var rssi: Int
    // TX power might not be available for all devices
    let txPower: Int?
    
    init(name: String, rssi: Int, txPower: Int?) {
        self.name = name
        self.rssi = rssi
        self.txPower = txPower
    }
}
