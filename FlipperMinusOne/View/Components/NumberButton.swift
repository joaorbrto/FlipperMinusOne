//
//  NumberButton.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/08/25.
//

import SwiftUI

struct NumberButton: View {
    let number: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(number)
                .font(.title2)
                .frame(width: 56, height: 56)
                .background(Color.numberbuttoncolor)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
