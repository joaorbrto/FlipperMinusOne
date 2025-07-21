//
//  PulseDetectorView.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 16/07/25.
//

import SwiftUI

struct PulseDetectorView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.accent.opacity(0.2))
                .frame(width: 280, height: 280)
                .scaleEffect(isAnimating ? 1.30 : 1.0)
                .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true), value: isAnimating)

            Circle()
                .fill(Color.accent.opacity(0.4))
                .frame(width: 240, height: 240)
                .scaleEffect(isAnimating ? 1.20 : 1.0)
                .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true), value: isAnimating)

            Circle()
                .fill(Color.accent.opacity(0.6))
                .frame(width: 200, height: 200)
                .scaleEffect(isAnimating ? 1.10 : 1.0)
                .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true), value: isAnimating)

        }
        .frame(height: 400) 
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    PulseDetectorView()
}
