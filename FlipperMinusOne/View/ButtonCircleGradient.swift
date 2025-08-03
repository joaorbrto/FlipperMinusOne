//
//  ButtonCircleGradient.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 03/08/25.
//

import SwiftUI

struct CircleButtonGradient: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.gradientstart, .gradientend]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 60)

                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.black.opacity(0.8))
                    .bold()
            }
        }
    }
}
