//
//  JammerDetectorView.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 23/07/25.
//

import SwiftUI

enum JammerDetectionState {
    case idle, scanning, detected, notDetected
}

struct JammerDetectorView: View {
    @ObservedObject var mqttManager: MQTTManager
    @State private var detectionState: JammerDetectionState = .scanning

    var body: some View {
        ZStack {
            Color.colorback
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer()

                PulseDetectorView(color: corDoPulso)
                    .frame(width: 200, height: 400)

                Text(titulo)
                    .font(.title)
                    .bold()

                Text(mensagem)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
        .onReceive(mqttManager.$receivedCommand) { command in
            guard let command = command else { return }
            switch command.command {
            case .jammersDetected:
                detectionState = .detected
            case .infraOn, .infraOff:
                detectionState = .notDetected
            default:
                break
            }
        }
    }

    private var titulo: String {
        switch detectionState {
        case .idle, .scanning: return "Buscando sinal de Jammer..."
        case .detected: return "Jammer detectado!"
        case .notDetected: return "Jammer não detectado!"
        }
    }

    private var mensagem: String {
        switch detectionState {
        case .scanning:
            return "Aguarde enquanto realizamos a varredura."
        case .detected:
            return "Um Jammer foi detectado na área em que você se encontra."
        case .notDetected:
            return "Nenhum Jammer foi detectado na área em que você se encontra."
        case .idle:
            return ""
        }
    }

    private var corDoPulso: Color {
        switch detectionState {
        case .scanning: return .accent
        case .detected: return .red
        case .notDetected: return .green
        case .idle: return .clear
        }
    }
}

#Preview {
    JammerDetectorView(mqttManager: MQTTManager())
}
