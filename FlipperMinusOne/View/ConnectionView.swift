//
//  ConnectionView.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 23/07/25.
//

import SwiftUI

struct MQTTConnectView: View {
    @StateObject var mqttManager = MQTTManager()

    @State private var host: String = "test.mosquitto.org"
    @State private var port: String = "1883"
    @State private var isConnected = false

    @State private var mensagemTeste: String = "ativo"

    var body: some View {
        VStack(spacing: 24) {
            Text("Conexão MQTT")
                .font(.title2)
                .bold()
            
            VStack(spacing: 12) {
                TextField("Host", text: $host)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Porta", text: $port)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)

            Button(action: {
                if isConnected {
                    mqttManager.disconnect()
                    isConnected = false
                } else {
                    mqttManager.configureMQTT(host: host, port: UInt16(port) ?? 1883)
                    isConnected = true
                }
            }) {
                Text(isConnected ? "Desconectar" : "Conectar")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isConnected ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            if let data = mqttManager.receivedData {
                HStack(spacing: 4) {
                    Image(systemName: "powerplug.portrait")
                    Text(data.status)
                }
                .font(.subheadline)
                .foregroundColor(.orange)
                .padding(.top, 8)
            }

            // 📤 Campo e botão de envio
            VStack(spacing: 12) {
                TextField("Mensagem de status", text: $mensagemTeste)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button("Publicar mensagem") {
                    let json = "{\"status\":\"\(mensagemTeste)\"}"
                    mqttManager.publish(message: json, topic: "flipper/status")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview{
    MQTTConnectView()
}
