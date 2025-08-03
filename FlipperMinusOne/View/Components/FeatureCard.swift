//
//  FeatureCard.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 21/07/25.
//

import SwiftUI

struct FeatureCard: View {
    var title: String
    var icon: String

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)

            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .frame(width: 174, height: 142)
        .background(Color.cardcolor)
        .cornerRadius(12)
    }
}

#Preview {
    FeatureCard(title: "Jammer", icon: "JammerRadar")
}
