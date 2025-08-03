//
//  BigCircleButton.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 03/08/25.
//

import SwiftUI

struct BigCircleButton: View {
    let gridSpacing: CGFloat = 12
    @ObservedObject var mqttManager: MQTTManager

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.bigcirclecolor) // opcional: leve destaque do círculo base
                .frame(width: 206, height: 202)

            VStack(spacing: 80) {
                CircleButton(icon: "chevron.up", color: .clear) {
                    mqttManager.sendCommand(.up)
                }

                CircleButton(icon: "chevron.down", color: .clear) {
                    mqttManager.sendCommand(.down)
                }
            }

            HStack(spacing: gridSpacing) {
                CircleButton(icon: "chevron.left", color: .clear) {
                    mqttManager.sendCommand(.left)
                }

                CircleButton(label: "OK", color: .okcolor) {
                    mqttManager.sendCommand(.ok)
                }

                CircleButton(icon: "chevron.right", color: .clear) {
                    mqttManager.sendCommand(.right)
                }
            }
        }
    }
}

#Preview {
    BigCircleButton(mqttManager: MQTTManager.shared)
}
