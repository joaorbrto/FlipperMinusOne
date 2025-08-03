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
            VStack(spacing: 24) {
                
                Text("FlippEdu")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .padding(.trailing, 250)
                
                HStack {
                    VStack(spacing: 8) {
                        VStack(alignment: .leading, spacing: 4) {
                            
                            
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
                        .frame(maxWidth: 250, alignment: .leading)
                    }
                    
                    Image("ESPSymbol")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90, height: 84)
                        .foregroundColor(.orange)
                }
                .padding(.top, 20)
                
                // Título funcionalidades
                HStack {
                    Text("Funcionalidades")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
                
                // Cartões de funcionalidades
                HStack(spacing: 20) {
                    NavigationLink(destination: JammerDetectorView(mqttManager: mqttManager)) {
                        FeatureCard(title: "Detecção   de Jammer", icon: "JammerRadar")
                    }
                    NavigationLink(destination: IRRemoteControlView(mqttManager: mqttManager)) {
                        FeatureCard(title: "Controle Infravermelho", icon: "IRControl")
                    }
                }
                
                // Título saiba mais
                HStack {
                    Text("Saiba mais")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
                
                // Cartões informativos
                VStack(spacing: 16) {
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
                .frame(maxWidth: 400)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 10)
            .sheet(isPresented: $showInfoJammer) {
                infoJammer(isPresented: $showInfoJammer)
            }
            .sheet(isPresented: $showInfoIR) {
                infoIR(isPresented: $showInfoIR)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}


#Preview {
    let mockManager = MQTTManager.shared
    mockManager.deviceName = "ESP Flipper"
    mockManager.isConnected = true
    return HomePage(mqttManager: mockManager)
}
