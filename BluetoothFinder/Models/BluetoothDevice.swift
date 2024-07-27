//
//  BluetoothDevice.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import Foundation

struct BluetoothDevice: Identifiable {
    // Use the device's name as the unique identifier
    var id: String { name }
    let name: String
    let rssi: Int
    // Transmit power might not be available for all devices
    let txPower: Int?
}
