//
//  JammerDetectorView.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 23/07/25.
//

import SwiftUI

enum JammerDetectionState {
    case idle
    case scanning
    case detected
    case notDetected
}

import SwiftUI

struct JammerDetectorView: View {
    @State private var detectionState: JammerDetectionState = .idle
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 32) {
            Text(titulo)
                .font(.title2)
                .bold()

            ZStack {
                if detectionState != .idle {
                    PulseDetectorView(color: corDoPulso)
                } else {
                    Image(systemName: "wifi.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .frame(height: 300)

            Text(mensagem)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            if detectionState == .idle {
                Button("Detectar") {
                    iniciarDeteccao()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.brown)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }

    private var titulo: String {
        switch detectionState {
        case .idle:
            return "Detectar Jammer"
        case .scanning:
            return "Buscando sinal de Jammer..."
        case .detected:
            return "Jammer detectado!"
        case .notDetected:
            return "Jammer não detectado!"
        }
    }

    private var mensagem: String {
        switch detectionState {
        case .idle:
            return ""
        case .scanning:
            return "Aguarde enquanto realizamos a varredura."
        case .detected:
            return "Um Jammer foi detectado na área em que você se encontra."
        case .notDetected:
            return "Nenhum Jammer foi detectado na área em que você se encontra."
        }
    }

    private var corDoPulso: Color {
        switch detectionState {
        case .scanning: return .brown
        case .detected: return .red
        case .notDetected: return .green
        default: return .clear
        }
    }

    private func iniciarDeteccao() {
        detectionState = .scanning

        // Simulação: após 3 segundos decide se detectou ou não
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // Aqui você substitui pelo feedback real do Flipper
            let detectou = Bool.random()
            detectionState = detectou ? .detected : .notDetected
        }
    }
}

#Preview {
    JammerDetectorView()
}
