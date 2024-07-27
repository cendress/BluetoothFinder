//
//  DeviceLocationView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import CoreHaptics
import SwiftUI

struct DeviceLocationView: View {
    @State private var engine: CHHapticEngine?
    
    let device: BluetoothDevice
    
    private var backgroundColor: Color {
        return device.rssi > -60 ? Color.green : Color.red
    }
    
    var body: some View {
        GeometryReader { geometry in
                Circle()
                    .fill(Color.white)
                    .shadow(radius: 10)
                    .padding()
                    .frame(width: circleSize(geometry: geometry), height: circleSize(geometry: geometry))
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            .onAppear {
                prepareHaptics()
            }
            .onChange(of: device.rssi) { newValue, oldValue in
                performHapticFeedback(rssi: newValue)
            }
        }
        .background(backgroundColor)
        .navigationTitle("Device Location")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Calculate circle size based on RSSI value
    private func circleSize(geometry: GeometryProxy) -> CGFloat {
        let normalizedRSSI = min(max(Double(device.rssi + 100) / 70.0, 0.2), 1.0)
        let diameter = normalizedRSSI * geometry.size.width
        return diameter
    }
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    private func performHapticFeedback(rssi: Int) {
        guard let engine = engine, CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        let normalizedRSSI = 1 - min(max(Double(device.rssi) / -100, 0), 1)
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(normalizedRSSI))
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(normalizedRSSI))
        
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

#Preview {
    let sampleDevice = BluetoothDevice(name: "Router", rssi: 0)
    return DeviceLocationView(device: sampleDevice)
}
