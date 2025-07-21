//
//  HomePage.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 21/07/25.
//

import SwiftUI

struct HomePage: View {
    @ObservedObject var router = Router.shared
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("O dispositivo é")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        
                        Text("Nome do dispositivo")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "powerplug.portrait")
                            Text("Conectado")
                        }
                        .font(.subheadline)
                        .foregroundColor(.orange)
                    }
                    
                    Spacer()
                    
                    Image("ESPSymbol")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90, height: 84)
                        .foregroundColor(.orange)
                }
                
                Text("Funcionalidades")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack(spacing: 20) {
                    Button {
                        router.goToJammerRadar()
                    } label: {
                        FeatureCard(title: "Detecção   de Jammer", icon: "JammerRadar")
                    }
                    FeatureCard(title: "Controle Infravermelho", icon: "IRControl")
                }
                
                
                Text("Saiba mais")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack {
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 16) {
                        InfoCard(
                            title: "Como detectar um Jammer?",
                            description: "O Jammer é um dispositivo que emite sinais para interferir e bloquear outros sinais.",
                            icon: "JammerDetect"
                        )
                        
                        InfoCard(
                            title: "Como detectar um Jammer?",
                            description: "O Jammer é um dispositivo que emite sinais para interferir e bloquear outros sinais.",
                            icon: "IRCommand"
                        )
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
            .background(Color.colorback.edgesIgnoringSafeArea(.all))
            .navigationTitle("Home")
            .navigationDestination(for: Views.self) { view in
                switch view {
                case .PulseDetectorView:
                    PulseDetectorView()
                default:
                    EmptyView()
                }
            }
            
        }
    }
}

#Preview {
    HomePage()
}
