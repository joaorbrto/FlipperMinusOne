//
//  CircleButton.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/08/25.
//

import SwiftUI

struct CircleButton: View {
    var icon: String? = nil
    var label: String? = nil
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 56, height: 56)
                    if let icon = icon {
                        Image(systemName: icon)
                            .foregroundColor(.white)
                            .font(.title2)
                    } else if let label = label {
                        Text(label)
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                if let label = label {
                    Text(label)
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 24) {
            CircleButton(icon: "power") {
                print("Botão Power pressionado")
            }

            CircleButton(label: "OK") {
                print("Botão OK pressionado")
            }

            CircleButton(icon: "play.fill", label: "Play") {
                print("Play pressionado")
            }
        }
    }
}


