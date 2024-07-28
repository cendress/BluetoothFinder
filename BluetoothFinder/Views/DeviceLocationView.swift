//
//  DeviceLocationView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/27/24.
//

import CoreHaptics
import SwiftUI

struct DeviceLocationView: View {
    
    //MARK: - Properties
    
    @Environment(\.dismiss) var dismiss
    @State private var engine: CHHapticEngine?
    
    let device: BluetoothDevice
    
    private var backgroundColor: Color {
        device.rssi > -60 ? .green : .red
    }
    
    private var distanceString: String {
        guard let txPower = device.txPower else { return "Unknown" }
        
        let rssi = Double(device.rssi)
        let txPowerDouble = Double(txPower)
        let pathLossExponent = 2.0
        
        let ratioDB = txPowerDouble - rssi
        let ratioLinear = pow(10, ratioDB / (10 * pathLossExponent))
        
        let meters = ratioLinear
        let feet = meters * 3.28084
        
        return String(format: "%.0f feet", feet)
    }
    
    //MARK: - View body
    
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
                if device.txPower != nil {
                    Text("Estimated Distance: \(distanceString)")
                } else {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.orange)
                            .padding(.bottom, 5)
                        Text("Distance Estimation Unavailable")
                            .italic()
                    }
                    .padding()
                }
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
    
    //MARK: - Circle size method
    
    private func circleSize(geometry: GeometryProxy) -> CGFloat {
        let normalizedRSSI = min(max(1.0 - (Double(device.rssi + 100) / 70.0), 0.2), 1.0)
        return normalizedRSSI * geometry.size.width
    }
    
    //MARK: - Haptics
    
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
        guard let engine = engine else { return }
        
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
