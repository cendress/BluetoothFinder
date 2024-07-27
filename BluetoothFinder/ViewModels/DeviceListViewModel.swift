//
//  DeviceListViewModel.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import Combine
import Foundation

class DeviceListViewModel: ObservableObject {
    @Published var devices: [BluetoothDevice] = []
    private var bluetoothManager = BluetoothManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        bluetoothManager.$discoveredDevices
            .receive(on: DispatchQueue.main)
            .assign(to: \.devices, on: self)
            .store(in: &cancellables)
    }
    
    func startScanning() {
        bluetoothManager.startScanning()
    }
}
