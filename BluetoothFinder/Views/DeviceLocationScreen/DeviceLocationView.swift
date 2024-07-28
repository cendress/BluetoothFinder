//
//  DeviceLocationView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import CoreHaptics
import SwiftUI

struct DeviceLocationView: View {
    @Environment(\.dismiss) var dismiss
    @State private var engine: CHHapticEngine?
    
    let device: BluetoothDevice
    
    private var backgroundColor: Color {
        device.rssi > -60 ? .green : .red
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                Circle()
                    .fill(.white)
                    .shadow(radius: 10)
                    .padding()
                    .frame(width: circleSize(geometry: geometry), height: circleSize(geometry: geometry))
                
                Spacer()
                
                // If device doesn't possess txPower, show image and text to indicate that distance estimation is not available
                DistanceInformationView(device: device)
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            .onAppear(perform: performHapticFeedback)
        }
        .background(backgroundColor)
        .navigationTitle("Device Location")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
            }
        }
    }
    
    private func circleSize(geometry: GeometryProxy) -> CGFloat {
        let normalizedRSSI = min(max(1.0 - (Double(device.rssi + 100) / 70.0), 0.2), 1.0)
        return normalizedRSSI * geometry.size.width
    }
    
    private func prepareHaptics() {
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating or starting the haptic engine: \(error.localizedDescription)")
        }
    }

    private func performHapticFeedback() {
        prepareHaptics()

        guard let engine = self.engine, CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print("Haptic feedback is not supported on this device.")
            return
        }

        let normalizedRSSI = 1 - min(max(Double(device.rssi) / -100, 0), 1)
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(normalizedRSSI))
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(normalizedRSSI))
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: .infinity)

        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Error playing haptic pattern: \(error.localizedDescription)")
        }
    }
}

#Preview {
    let sampleDevice = BluetoothDevice(name: "Router", rssi: 0, txPower: nil)
    
    return DeviceLocationView(device: sampleDevice)
}
