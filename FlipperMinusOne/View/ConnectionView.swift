//
//  ConnectionView.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 23/07/25.
//

import SwiftUI

struct MQTTConnectView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.colorback.ignoresSafeArea(.all)
                
                VStack(spacing: 32) {
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: HomePage()) {
                            Text("Pular")
                                .foregroundColor(.orange)
                        }
                        .padding(.trailing)
                    }
                    
                    VStack(spacing: 12) {
                        Text("Conecte com o dispositivo")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Para utilizar todos os recursos do aplicativo é necessário conectar o ESP32.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                    }
                    ZStack {
                        VStack {
                            
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.clear)
                                .frame(width: 271, height: 563)
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
                        
                        VStack {
                            Spacer()
                            
                            NavigationLink(destination: ConnectionForm()) {
                                Text("Continuar")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(width: 308, height: 50)
                                    .background(Color.accent)
                                    .cornerRadius(12)
                            }
                            .padding(.top)
                        }
                    }
                    
                }
                .padding(.top)
            }
        }
    }
}

#Preview {
    MQTTConnectView()
}
