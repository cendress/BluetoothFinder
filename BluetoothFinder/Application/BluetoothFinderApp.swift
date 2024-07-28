//
//  BluetoothFinderApp.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import SwiftUI

@main
struct BluetoothFinderApp: App {
    @StateObject var deviceListViewModel = DeviceListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(deviceListViewModel)
        }
    }
}
