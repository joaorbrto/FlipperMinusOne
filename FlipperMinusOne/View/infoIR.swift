//
//  infoIR.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/08/25.
//

import SwiftUI

struct infoIR: View {
    var body: some View {
        VStack {
            ZStack {
                Color.infoback
                    .ignoresSafeArea()
                
                Image("IRCommand")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 160)
            }
            .frame(width: 400, height: 181)
            
            Text("Lore Ipsum Lore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore IpsumLore Ipsum")
                .foregroundColor(.white)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colorback.ignoresSafeArea())
    }
}

#Preview {
    infoIR()
}
