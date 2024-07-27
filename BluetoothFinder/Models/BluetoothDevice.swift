//
//  BluetoothDevice.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import Foundation
import Combine

struct BluetoothDevice: Identifiable {
    // Use the device's name as the unique identifier
    var id: String { name }
    let name: String
    let rssi: Int
    // TX power might not be available for all devices
    let txPower: Int?
}
