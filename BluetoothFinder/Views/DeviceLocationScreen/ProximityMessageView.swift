//
//  ProximityMessageView.swift
//  BluetoothFinder
//
//  Created by Christopher Endress on 7/28/24.
//

import SwiftUI

struct ProximityMessageView: View {
    @ObservedObject var viewModel: DeviceLocationViewModel
    
    var body: some View {
        Text(viewModel.proximityMessage)
            .font(.title)
            .fontWeight(.bold)
            .padding()
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.5), value: viewModel.proximityMessage)
    }
}
