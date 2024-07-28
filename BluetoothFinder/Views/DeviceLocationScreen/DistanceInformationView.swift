//
//  DistanceInformationView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/28/24.
//

import SwiftUI

struct DistanceInformationView: View {
    let device: BluetoothDevice
    
    var body: some View {
        Group {
            if let txPower = device.txPower {
                Text("Estimated Distance: \(formattedDistance(txPower: txPower))")
            } else {
                // Display VStack when the TX power of a device can't be found
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.orange)
                        .padding(.bottom, 5)
                    Text("Distance Estimation Unavailable")
                        .italic()
                }
            }
        }
        .padding()
    }
    
    /// Calculates the estimated distance to a Bluetooth device based on RSSI and TX power
    /// This function uses a log-distance path loss model where the environment factor adjusts
    /// for different types of environments affecting signal propagation.
    /// - Parameters:
    ///   - txPower: The known transmitted power of the Bluetooth device at 1 meter, in dBm.
    ///   - environmentFactor: A factor typically ranging from 2.0 (open space) to 4.0 (urban environments),
    ///     which adjusts the rate at which the signal degrades with distance. This factor should be
    ///     empirically adjusted based on the environment where the app is used.
    /// - Returns: A string representing the estimated distance to the device in feet, rounded to the nearest whole number.
    private func formattedDistance(txPower: Int, environmentFactor: Double = 4.0) -> String {
        let rssi = Double(device.rssi)
        let txPowerDouble = Double(txPower)
        let ratioDB = txPowerDouble - rssi
        let ratioLinear = pow(10, ratioDB / (10 * environmentFactor))
        let meters = ratioLinear
        let feet = meters * 3.28084
        return String(format: "%.0f feet", feet)
    }
}

#Preview {
    let sampleDevice = BluetoothDevice(id: UUID(), name: "Personal Computer", rssi: -30, txPower: nil)
    
    return DistanceInformationView(device: sampleDevice)
}
