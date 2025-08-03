//
//  IRRemoteControlView.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/08/25.
//

import SwiftUI

struct IRRemoteControlView: View {
    @ObservedObject var mqttManager: MQTTManager
    @State private var lastNumberPressed: Int? = nil

    let gridSpacing: CGFloat = 8

    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                // Power e Mute
                HStack {
                    CircleButtonGradient(icon: "power") {
                        mqttManager.sendCommand(.power)
                    }

                    Spacer()

                    CircleButton(icon: "speaker.slash") {
                        mqttManager.sendCommand(.mute)
                    }
                }
                .padding(.horizontal, 40)

                // CH / botão central / VL
                HStack(spacing: 16) {
                    VerticalControl(label: "CH", upAction: {
                        mqttManager.sendCommand(.channelUp)
                    }, downAction: {
                        mqttManager.sendCommand(.channelDown)
                    })

                    BigCircleButton(mqttManager: mqttManager)

                    VerticalControl(label: "VL", upAction: {
                        mqttManager.sendCommand(.volumeUp)
                    }, downAction: {
                        mqttManager.sendCommand(.volumeDown)
                    })
                }

                // Teclado Numérico com largura fixa e centralizado
                VStack(spacing: gridSpacing) {
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.fixed(60), spacing: gridSpacing), count: 3),
                        spacing: gridSpacing
                    ) {
                        ForEach((1...9), id: \.self) { n in
                            NumberButton(number: "\(n)") {
                                mqttManager.sendCommand(.number, payload: "\(n)")
                            }
                        }
                    }
                    .frame(maxWidth: 3 * 60 + 2 * gridSpacing)

                    // Botão 0 centralizado
                    HStack {
                        Spacer()
                        NumberButton(number: "0") {
                            mqttManager.sendCommand(.number, payload: "0")
                        }
                        Spacer()
                    }
                    .frame(maxWidth: 3 * 60 + 2 * gridSpacing)
                }

                // Controles Inferiores
                HStack(spacing: 32) {
                    CircleButton(icon: "pause.fill", label: "Pause") {
                        mqttManager.sendCommand(.pause)
                    }
                    CircleButton(icon: "play.fill", label: "Play/Stop") {
                        mqttManager.sendCommand(.play)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .onReceive(mqttManager.$receivedCommand) { command in
            guard let command = command else { return }

            if command.command == .number,
               let payload = command.payload,
               let num = Int(payload) {
                lastNumberPressed = num
            }
        }
        .navigationTitle("Controle Remoto")
    }
}

#Preview {
    IRRemoteControlView(mqttManager: MQTTManager())
}
