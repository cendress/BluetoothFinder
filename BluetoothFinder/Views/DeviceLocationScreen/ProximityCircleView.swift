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

    var body: some View {
        Circle()
            .fill(.white)
            .shadow(radius: 10)
            .padding()
            .frame(width: circleSize(), height: circleSize())
    }
    
    private func circleSize() -> CGFloat {
        let normalizedRSSI = min(max(1.0 - (Double(rssi + 100) / 70.0), 0.2), 1.0)
        return normalizedRSSI * geometry.size.width
    }
}
