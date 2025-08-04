//
//  BigCircleButton.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 03/08/25.
//

import SwiftUI

struct BigCircleButton: View {
    let gridSpacing: CGFloat = 12
    let onCommand: (IRCommandPreset) -> Void

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.bigcirclecolor)
                .frame(width: 206, height: 202)

            VStack(spacing: 80) {
                CircleButton(icon: "chevron.up", color: .clear) {
                    onCommand(.up)
                }

                CircleButton(icon: "chevron.down", color: .clear) {
                    onCommand(.down)
                }
            }

            HStack(spacing: gridSpacing) {
                CircleButton(icon: "chevron.left", color: .clear) {
                    onCommand(.left)
                }

                CircleButton(label: "OK", color: .okcolor) {
                    onCommand(.ok)
                }

                CircleButton(icon: "chevron.right", color: .clear) {
                    onCommand(.right)
                }
            }
        }
    }
}

#Preview {
    BigCircleButton { preset in
        print("🔘 Comando enviado: \(preset)")
    }
}
