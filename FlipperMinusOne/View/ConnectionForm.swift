//
//  ConnectionForm.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 29/07/25.
//

import SwiftUI

struct ConnectionForm: View {
    @StateObject var mqttManager = MQTTManager.shared

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
            ZStack {
                Color.black
                    .ignoresSafeArea()
                    .onTapGesture {
                        dismissKeyboard()
                    }

                VStack(alignment: .center, spacing: 44) {
                    Text("Conecte com a ESP")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .frame(maxWidth: .infinity)
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

                        mqttManager.deviceName = deviceName
                        mqttManager.configureMQTT(
                            host: host,
                            port: UInt16(port) ?? 1883,
                            subscribeTopic: "/flippedu/device",
                            publishTopic: "/flippedu/app"
                        )
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

                    NavigationLink(destination: HomePage(mqttManager: mqttManager), isActive: $shouldNavigate) {
                        EmptyView()
                    }
                    .hidden()
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onReceive(mqttManager.$isConnected) { isConnected in
                    if isConnected {
                        shouldNavigate = true
                    }
                }
            }
            .ignoresSafeArea(.keyboard) // <- evita mover tela ao abrir teclado
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
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .padding()
                .background(Color.infoback)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .foregroundColor(.white)
        }
    }

    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#Preview {
    ConnectionForm()
}
