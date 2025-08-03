//
//  SplashScreen.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 03/08/25.
//

import SwiftUI

struct SplashScreen: View {
    @State private var showLabel = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 24) {
                Image("Edu")

                Image("FilppEdulabel")
                    .opacity(showLabel ? 1 : 0)
                    .scaleEffect(showLabel ? 1 : 0.8)
                    .animation(.easeOut(duration: 1.0), value: showLabel)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showLabel = true
            }
        }
    }
}

#Preview {
    SplashScreen()
}
