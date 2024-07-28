//
//  ProximityCircleView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/28/24.
//

import SwiftUI

struct ProximityCircleView: View {
    var rssi: Int
    var geometry: GeometryProxy
    
    private let closeProximityThreshold = -40
    
    var body: some View {
        Circle()
            .fill(self.isClose ? Color.white : Color.white.opacity(0.8))
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: isClose ? 4 : 0)
                    .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isClose)
                    .opacity(isClose ? 1 : 0)
            )
            .animation(.easeInOut(duration: 0.5), value: isClose)
            .shadow(radius: 10)
            .padding()
            .frame(width: circleSize(), height: circleSize())
    }
    
    private var isClose: Bool {
        rssi > closeProximityThreshold
    }
    
    private func circleSize() -> CGFloat {
        let normalizedRSSI = min(max(1.0 - (Double(rssi + 100) / 70.0), 0.2), 1.0)
        return normalizedRSSI * geometry.size.width
    }
}
