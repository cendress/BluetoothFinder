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
    
    private var distanceString: String {
        guard let txPower = device.txPower else { return "Unknown" }
        
        let ratio = Double(device.rssi) / Double(txPower)
        let meters: Double = ratio < 1.0 ? pow(ratio, 10) : 0.89976 * pow(ratio, 7.7095) + 0.111
        let feet = meters * 3.28084
        return String(format: "%.2f feet", feet)
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
                
                Text("Estimated Distance: \(distanceString)")
                    .padding()
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            .onAppear(perform: prepareHaptics)
            .onChange(of: device.rssi) {
                performHapticFeedback()
            }
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
        let normalizedRSSI = min(max(Double(device.rssi + 100) / 70.0, 0.2), 1.0)
        return normalizedRSSI * geometry.size.width
    }
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Error starting the haptic engine: \(error)")
        }
    }
    
    private func performHapticFeedback() {
        guard let engine = engine, CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        let normalizedRSSI = 1 - min(max(Double(device.rssi) / -100, 0), 1)
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(normalizedRSSI))
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(normalizedRSSI))
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0)
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Error playing haptic pattern: \(error)")
        }
    }
}

#Preview {
    let sampleDevice = BluetoothDevice(name: "Router", rssi: 0, txPower: nil)
    return DeviceLocationView(device: sampleDevice)
}
