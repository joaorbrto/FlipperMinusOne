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
    let gridSpacing: CGFloat = 12

    var body: some View {
        ZStack {
            Color.colorback.ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Controle Infravermelho")
                    .font(.title2)
                    .bold()
                    .padding(.top)

                HStack {
                    CircleButton(icon: "power") {
                        mqttManager.sendCommand(.power)
                    }
                    Spacer()
                    CircleButton(icon: "speaker.slash") {
                        mqttManager.sendCommand(.mute)
                    }
                }
                .padding(.horizontal, 40)

                // Navegação
                ZStack {
                    VStack(spacing: gridSpacing) {
                        CircleButton(icon: "chevron.up") {
                            mqttManager.sendCommand(.up)
                        }

                        CircleButton(icon: "chevron.down") {
                            mqttManager.sendCommand(.down)
                        }
                    }

                    HStack(spacing: gridSpacing) {
                        CircleButton(icon: "chevron.left") {
                            mqttManager.sendCommand(.left)
                        }

                        CircleButton(label: "OK") {
                            mqttManager.sendCommand(.ok)
                        }

                        CircleButton(icon: "chevron.right") {
                            mqttManager.sendCommand(.right)
                        }
                    }
                }

                // Volume e Canal
                HStack(spacing: 32) {
                    VerticalControl(label: "CH", upAction: {
                        mqttManager.sendCommand(.channelUp)
                    }, downAction: {
                        mqttManager.sendCommand(.channelDown)
                    })

                    VerticalControl(label: "🔊", upAction: {
                        mqttManager.sendCommand(.volumeUp)
                    }, downAction: {
                        mqttManager.sendCommand(.volumeDown)
                    })
                }

                // Teclado Numérico
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                    ForEach((1...9), id: \.self) { n in
                        NumberButton(number: "\(n)") {
                            mqttManager.sendCommand(.number, payload: "\(n)")
                        }
                    }

                    NumberButton(number: "0") {
                        mqttManager.sendCommand(.number, payload: "0")
                    }
                }

                // Controles Inferiores
                HStack(spacing: 32) {
                    CircleButton(icon: "pause.fill", label: "Pause") {
                        mqttManager.sendCommand(.pause)
                    }
                    CircleButton(icon: "play.fill", label: "Play/Stop") {
                        mqttManager.sendCommand(.play)
                    }
                    CircleButton(icon: "lightbulb", label: "Brilho") {
                        mqttManager.sendCommand(.brightness)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .onReceive(mqttManager.$receivedCommand) { command in
                    guard let command = command else { return }

                    switch command.command {
                    case .number:
                        if let payload = command.payload, let num = Int(payload) {
                            lastNumberPressed = num
                        }
                    default:
                        break
                    }
                }
            }
        }

#Preview {
    IRRemoteControlView(mqttManager: MQTTManager())
}
