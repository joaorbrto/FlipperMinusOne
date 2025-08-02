//
//  VerticalControl.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/08/25.
//

import SwiftUI

struct VerticalControl: View {
    var label: String
    var upAction: () -> Void
    var downAction: () -> Void

    var body: some View {
        VStack(spacing: 4) {
            Button(action: upAction) {
                Image(systemName: "plus")
                    .font(.title2)
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }

            Text(label)
                .foregroundColor(.white)
                .font(.caption)

            Button(action: downAction) {
                Image(systemName: "minus")
                    .font(.title2)
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
        }
    }
}

