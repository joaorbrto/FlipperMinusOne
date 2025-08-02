//
//  HomePage.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 21/07/25.
//

import SwiftUI

struct HomePage: View {
    @ObservedObject var mqttManager: MQTTManager
    
    @State private var showInfoJammer = false
    @State private var showInfoIR = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("O dispositivo é")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        
                        Text(mqttManager.deviceName.isEmpty ? "Desconhecido" : mqttManager.deviceName)
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "powerplug.portrait")
                            Text(mqttManager.isConnected ? "Conectado" : "Desconectado")
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
                    HStack(spacing: 20) {
                        NavigationLink(destination: JammerDetectorView(mqttManager: mqttManager)) {
                            FeatureCard(title: "Detecção   de Jammer", icon: "JammerRadar")
                        }
                        NavigationLink(destination: IRRemoteControlView(mqttManager: mqttManager)) {
                            FeatureCard(title: "Controle Infravermelho", icon: "IRControl")
                            
                        }
                    }
                }
                
                Text("Saiba mais")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack {
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 16) {
                        Button {
                            showInfoJammer = true
                        } label: {
                            InfoCard(
                                title: "Como detectar um Jammer?",
                                description: "O Jammer é um dispositivo que emite sinais para interferir e bloquear outros sinais.",
                                icon: "JammerDetect"
                            )
                        }
                        
                        Button {
                            showInfoIR = true
                        } label: {
                            InfoCard(
                                title: "Comando IR?",
                                description: "Envie comandos infravermelhos para controlar dispositivos compatíveis.",
                                icon: "IRCommand"
                            )
                        }
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
            .background(Color.colorback.edgesIgnoringSafeArea(.all))
            .navigationTitle("Home")
            .sheet(isPresented: $showInfoJammer) {
                infoJammer()
            }
            .sheet(isPresented: $showInfoIR) {
                infoIR()
            }
        }
    }
}
#Preview {
    let mockManager = MQTTManager.shared
    mockManager.deviceName = "ESP Flipper"
    mockManager.isConnected = true
    return HomePage(mqttManager: mockManager)
}
