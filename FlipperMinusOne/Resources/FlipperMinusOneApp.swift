//
//  FlipperMinusOneApp.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 08/07/25.
//

import SwiftUI

@main
struct FlipperMinusOneApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            showSplash = false
                        }
                    }
                    .preferredColorScheme(.dark)
            } else {
                MQTTConnectView()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
