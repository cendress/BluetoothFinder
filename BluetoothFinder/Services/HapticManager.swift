//
//  HapticManager.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/28/24.
//

import CoreHaptics
import SwiftUI

class HapticManager {
    private var engine: CHHapticEngine?
    
    private func prepareHaptics() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating or starting the haptic engine: \(error.localizedDescription)")
        }
    }
    
    func performHapticFeedback(fromRSSI rssi: Int) {
        prepareHaptics()
        
        guard let engine = engine, CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print("Haptic feedback is not supported on this device.")
            return
        }
        
        // Normalize the RSSI value to a scale of 0 to 1 and create haptic parameters
        let normalizedRSSI = 1 - min(max(Double(rssi) / -100, 0), 1)
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(normalizedRSSI))
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(normalizedRSSI))
        
        // Create a continuous haptic event with the specified intensity and sharpness
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: .infinity)
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Error playing haptic pattern: \(error.localizedDescription)")
        }
    }
    
    // Necessary to stop the engine running when the view gets dismissed
    func stopHaptics() {
        engine?.stop { error in
            if let error = error {
                print("Error stopping the haptic engine: \(error.localizedDescription)")
            }
        }
    }
}
