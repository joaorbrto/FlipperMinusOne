//
//  espinphone.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/08/25.
//

import SwiftUI

struct espinphone: View {
    var body: some View {
        
        ZStack {
            VStack {
                
                Spacer()
                
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.clear)
                .frame(width: 271, height: 573)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                )
            }.ignoresSafeArea(edges: .all)
            Circle()
                .fill(Color.clear)
                .frame(width: 127, height: 127)
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                )
            
            Image("espgray")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
        }
    }
}

#Preview {
    espinphone()
}
