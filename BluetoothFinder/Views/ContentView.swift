//
//  ContentView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            DeviceListView()
        }
    }
}

#Preview {
    ContentView()
}
