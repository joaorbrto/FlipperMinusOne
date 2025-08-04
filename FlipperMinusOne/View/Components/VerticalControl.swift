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
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.numberbuttoncolor)
                .frame(width: 50, height: 150)
                .shadow(radius: 8)
            
            VStack(spacing: 20) {
                Button(action: upAction) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .padding(8)
                        .foregroundStyle(.white)
                }
                
                Text(label)
                    .foregroundColor(.white)
                    //.font()
                
                Button(action: downAction) {
                    Image(systemName: "minus")
                        .font(.title2)
                        .padding(8)
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            VerticalControl(label: "CH", upAction: {
                print("Canal +")
            }, downAction: {
                print("Canal −")
            })

            VerticalControl(label: "VL", upAction: {
                print("Volume +")
            }, downAction: {
                print("Volume −")
            })
        }
        .padding()
    }
}
