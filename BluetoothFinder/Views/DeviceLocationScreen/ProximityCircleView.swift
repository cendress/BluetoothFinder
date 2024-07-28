//
//  ProximityCircleView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/28/24.
//

import SwiftUI

struct ProximityCircleView: View {
    @ObservedObject var viewModel: DeviceLocationViewModel
    var geometry: GeometryProxy
    private let closeProximityThreshold = -40
    
    private var isClose: Bool {
        viewModel.device.rssi > closeProximityThreshold
    }
    
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
    
    private func circleSize() -> CGFloat {
        let normalizedRSSI = min(max(1.0 - (Double(viewModel.device.rssi + 100) / 70.0), 0.2), 1.0)
        return normalizedRSSI * geometry.size.width
    }
}
