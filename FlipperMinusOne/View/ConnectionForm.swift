//
//  ConnectionForm.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 29/07/25.
//

import SwiftUI

struct ConnectionForm: View {
    @Binding var isExpanded: Bool

    @StateObject var mqttManager = MQTTManager()

    @State private var host: String = ""
    @State private var port: String = ""
    @State private var deviceName: String = ""
    @State private var isConnected = false
    @State private var showValidationError = false

    private var formIsValid: Bool {
        !host.isEmpty && !port.isEmpty && !deviceName.isEmpty
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("Conecte com o dispositivo")
                .font(.title)
                .bold()

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

                if isConnected {
                    mqttManager.disconnect()
                    isConnected = false
                } else {
                    mqttManager.configureMQTT(host: host, port: UInt16(port) ?? 1883)
                   // Router.shared.deviceName = deviceName
                    isConnected = true
                }
            }) {
                Text("Continuar")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(formIsValid ? (isConnected ? Color.accent : Color.accent) : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .disabled(!formIsValid)

            if showValidationError {
                Text("Preencha todos os campos antes de conectar.")
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.top, -8)
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
        }
        .padding(.top)
        .frame(height: isExpanded ? UIScreen.main.bounds.height * 0.9 : UIScreen.main.bounds.height * 0.5)
        .frame(maxWidth: .infinity)
        .background(Color.corSistema)
        .cornerRadius(24)
        .shadow(radius: 8)
        .ignoresSafeArea(.all)
        .animation(.easeInOut, value: isExpanded)
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
    StatefulPreviewWrapper(false) { isExpanded in
        ConnectionForm(isExpanded: isExpanded)
    }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: value)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
