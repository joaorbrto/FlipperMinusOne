//
//  ConnectionView.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 23/07/25.
//

import SwiftUI

struct MQTTConnectView: View {
    @State private var isExpanded: Bool = false

    var body: some View {
        ZStack {
            Color.colorback.ignoresSafeArea(edges: .all)

            RoundedRectangle(cornerRadius: 24)
                .fill(Color.clear)
                .frame(width: 263, height: 365)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                )

            Circle()
                .fill(Color.clear)
                .frame(width: 127, height: 127)
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                )

            Image("espgray")

            VStack {
                Spacer()
                Button("Alternar Sheet") {
                    withAnimation(.easeInOut) {
                        isExpanded.toggle()
                    }
                }

                ConnectionForm(isExpanded: $isExpanded)
            }
            .padding()
        }
    }
}
#Preview{
    MQTTConnectView()
}
