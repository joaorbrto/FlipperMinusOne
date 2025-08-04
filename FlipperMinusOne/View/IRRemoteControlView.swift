//
//  IRRemoteControlView.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/08/25.
//

//
//  IRRemoteControlView.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/08/25.
//

import SwiftUI

struct IRRemoteControlView: View {
    @ObservedObject var mqttManager: MQTTManager

    let gridSpacing: CGFloat = 8

    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                // Power e Mute
                HStack {
                    CircleButtonGradient(icon: "power") {
                        mqttManager.sendIRPreset(.power)
                    }

                    Spacer()

                    CircleButton(icon: "speaker.slash") {
                        mqttManager.sendIRPreset(.mute)
                    }
                }
                .padding(.horizontal, 40)

                // CH / botão central / VL
                HStack(spacing: 16) {
                    VerticalControl(label: "CH", upAction: {
                        mqttManager.sendIRPreset(.channelUp)
                    }, downAction: {
                        mqttManager.sendIRPreset(.channelDown)
                    })

                    BigCircleButton { preset in
                        // Quando for .ok, envia retransmit
                        if preset == .ok {
                            mqttManager.sendRetransmitCommand()
                        } else {
                            mqttManager.sendIRPreset(preset)
                        }
                    }

                    VerticalControl(label: "VL", upAction: {
                        mqttManager.sendIRPreset(.volumeUp)
                    }, downAction: {
                        mqttManager.sendIRPreset(.volumeDown)
                    })
                }

                // Teclado Numérico com largura fixa e centralizado
                VStack(spacing: gridSpacing) {
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.fixed(60), spacing: gridSpacing), count: 3),
                        spacing: gridSpacing
                    ) {
                        ForEach(1...9, id: \.self) { n in
                            NumberButton(number: "\(n)") {
                                if let preset = numberCommand(for: n) {
                                    mqttManager.sendIRPreset(preset)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: 3 * 60 + 2 * gridSpacing)

                    // Botão 0 centralizado
                    HStack {
                        Spacer()
                        NumberButton(number: "0") {
                            mqttManager.sendIRPreset(._0)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: 3 * 60 + 2 * gridSpacing)
                }

                // Controles Inferiores
                HStack(spacing: 32) {
                    CircleButton(icon: "pause.fill", label: "Pause") {
                        mqttManager.sendIRPreset(.pause)
                    }
                    CircleButton(icon: "play.fill", label: "Play/Stop") {
                        mqttManager.sendRetransmitCommand()
                    }
                }
                if let signal = mqttManager.lastIRSignal {
                    VStack(spacing: 4) {
                        Text("'command': 'retransmit'")
                        Text("Protocolo: \(signal.`protocol`) Endereço: \(signal.address) Comando: \(signal.command)")
                    }
                    .font(.footnote)
                    .padding(.top, 12)
                    .transition(.opacity)
                }            }
            .padding()
        }
        .navigationTitle("Controle Remoto")
        .onAppear {
            print("⚙️ Entrando no modo IR...")
            mqttManager.sendMode(.ir)
        }
    }

    private func numberCommand(for n: Int) -> IRCommandPreset? {
        switch n {
        case 0: return ._0
        case 1: return ._1
        case 2: return ._2
        case 3: return ._3
        case 4: return ._4
        case 5: return ._5
        case 6: return ._6
        case 7: return ._7
        case 8: return ._8
        case 9: return ._9
        default: return nil
        }
    }
}
#Preview {
    IRRemoteControlView(mqttManager: MQTTManager())
}
