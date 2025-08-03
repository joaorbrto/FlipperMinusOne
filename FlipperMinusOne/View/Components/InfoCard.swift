//
//  InfoCard.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 21/07/25.
//

import SwiftUI

struct InfoCard: View {
    var title: String
    var description: String
    var icon: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()
                Text(description)
                    .font(.footnote)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(width: 250, height: 100, alignment: .leading)

            ZStack {
                Color.drawback

                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 86.11, height: 50)
            }
            .frame(width: 111, height: 100)
        }
        .background(Color.cardcolor)
        .cornerRadius(12)
        .frame(width: 361, height: 100)
    }
}

#Preview {
    InfoCard(
        title: "Como detectar um Jammer?",
        description: "O Jammer é um dispositivo que emite sinais para interferir e bloquear outros sinais.",
        icon: "JammerDetect"
    )
}
