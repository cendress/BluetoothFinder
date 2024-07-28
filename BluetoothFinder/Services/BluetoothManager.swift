//
//  BluetoothManager.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    @Published var discoveredDevices: [BluetoothDevice] = []
    private var centralManager: CBCentralManager!
    
    override init() {
        super.init()
        // Initialize central manager which handles all bluetooth related tasks and assign it's delegate to the current class (BluetoothManager)
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            // If Bluetooth is powered on, start scanning for peripherals
            startScanning()
        }
    }
    
    func startScanning() {
        // May want to add some scanning filters
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    // Triggers when a peripheral is found
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let txPower = advertisementData[CBAdvertisementDataTxPowerLevelKey] as? Int
        let newName = peripheral.name ?? "Unknown"
        
        if let index = discoveredDevices.firstIndex(where: {$0.name == newName}) {
            discoveredDevices[index].rssi = RSSI.intValue
        } else {
            let newDevice = BluetoothDevice(name: newName, rssi: RSSI.intValue, txPower: txPower)
            discoveredDevices.append(newDevice)
        }
    }
}
