//
//  EmptyDeviceView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/28/24.
//

import SwiftUI

struct EmptyDeviceView: View {
    var body: some View {
        Text("No devices found. Tap the Scan button to search for devices.")
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding()
    }
}

#Preview {
    EmptyDeviceView()
}
