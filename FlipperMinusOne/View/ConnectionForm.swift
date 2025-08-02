//
//  ConnectionForm.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 29/07/25.
//

import SwiftUI

struct ConnectionForm: View {
    @StateObject var mqttManager = MQTTManager()

    @State private var host: String = ""
    @State private var port: String = ""
    @State private var deviceName: String = ""
    @State private var showValidationError = false
    @State private var shouldNavigate = false

    private var formIsValid: Bool {
        !host.isEmpty && !port.isEmpty && !deviceName.isEmpty
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 44) {
                Text("Conectando com o dispositivo")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 48)

                VStack(spacing: 16) {
                    customField(title: "Nome do dispositivo", text: $deviceName, placeholder: "Qual o nome do dispositivo?")
                    customField(title: "Host", text: $host, placeholder: "Qual o host a ser conectado?")
                    customField(title: "Port", text: $port, placeholder: "Qual a porta a ser conectada?", keyboardType: .numberPad)
                }
                .padding(.horizontal)

                Button(action: {
                    if !formIsValid {
                        showValidationError = true
                        return
                    }

                    mqttManager.configureMQTT(host: host, port: UInt16(port) ?? 1883)
                    showValidationError = false
                }) {
                    Text("Continuar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(formIsValid ? Color.accent : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 200)
                .disabled(!formIsValid)

                if showValidationError {
                    Text("Preencha todos os campos antes de conectar.")
                        .font(.footnote)
                        .foregroundColor(.red)
                }

                if let data = mqttManager.receivedData {
                    HStack(spacing: 4) {
                        Image(systemName: "powerplug.portrait")
                        Text(data.status)
                    }
                    .font(.subheadline)
                    .foregroundColor(.orange)
                    .padding(.top, 8)
                }

                NavigationLink(destination: HomePage(), isActive: $shouldNavigate) {
                    EmptyView()
                }
                .hidden()
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.corSistema)
            .ignoresSafeArea()
            .onReceive(mqttManager.$isConnected) { newValue in
                if newValue {
                    shouldNavigate = true
                }
            }
        }
    }

    @ViewBuilder
    private func customField(title: String, text: Binding<String>, placeholder: String, keyboardType: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("*")
                    .foregroundColor(.red)
            }

            TextField(placeholder, text: text)
                .keyboardType(keyboardType)
                .padding()
                .background(Color.black.opacity(0.2))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ConnectionForm()
}
