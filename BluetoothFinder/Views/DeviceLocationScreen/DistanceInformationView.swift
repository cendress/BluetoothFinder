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
    
    private func formattedDistance(txPower: Int) -> String {
        let rssi = Double(device.rssi)
        let txPowerDouble = Double(txPower)
        let ratioDB = txPowerDouble - rssi
        let ratioLinear = pow(10, ratioDB / 20.0)
        let meters = ratioLinear
        let feet = meters * 3.28084
        return String(format: "%.0f feet", feet)
    }
}

#Preview {
    let sampleDevice = BluetoothDevice(name: "Personal Computer", rssi: -30, txPower: nil)
    
    return DistanceInformationView(device: sampleDevice)
}
