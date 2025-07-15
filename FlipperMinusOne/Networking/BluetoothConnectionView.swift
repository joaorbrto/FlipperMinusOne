//
//  BluetoothConnectionView.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 15/07/25.
//

import SwiftUI

struct BluetoothConnectionView: View {
    @StateObject private var bleManager = BLEManager()
    @State var navegar = false
    @State var pronto = false
    @State var isConnected = false
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Buscar dispositivo")
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
                    .foregroundStyle(.accent)
                    .padding(.top, 40)
                    .padding(.horizontal, 25)
                Text("Para utilizar todos os recursos que oferecemos, é necessário que o Bluettoth do seu iPhone esteja ligado e conectado com o ESP32.")
                    .font(.body)
                    .fontDesign(.rounded)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25)
                
                
                List(bleManager.discoveredPeripherals, id: \.peripheral.identifier) { device in
                    Button(action: {
                        bleManager.connectToPeripheral(device.peripheral)
                        pronto = true
                        isConnected.toggle()
                    }) {
                        HStack {
                            Text(device.name)
                                .font(.headline)
                            Spacer()
//                            if bleManager.connectedPeripheral?.identifier == device.peripheral.identifier {
//                                Text("Conectado!")
//                                    .foregroundColor(.blue)
//                            }
                            Text(bleManager.connectedPeripheral?.identifier == device.peripheral.identifier ? "Conectado!" : " ")
                                .font(.headline)
                        }
                    }
                    
                    
                }
                .scrollContentBackground(.hidden)
                .background(Color.white)
                .padding()
                
                Button(action: {
                    bleManager.startScanning()
                }) {
                    Text("Buscar mais dispositivos")
                    //                                    .fontWeight(.semibold)
                    //                                    .frame(minWidth: 0, maxWidth: .infinity)
                    //                                    .padding(.vertical, 16)
                    //                                    .background(Color.verdeComida)
                    //                                    .foregroundColor(.verdeFonte)
                    //                                    .cornerRadius(15)
                }/*.padding(.horizontal, 30)*/
               
                
//                NavigationLink(destination: instrucao2(bleManager: bleManager), isActive: $navegar) {
//                    EmptyView()
//                }
                Button(action: {
                    if pronto {
                        navegar = true
                    }
                    else {
                        navegar = false
                    }
                }) {
                    Text("Continuar")
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.accent)
                        .foregroundColor(.black)
                        .cornerRadius(15)
                }
                .padding(.bottom, 80)
                .padding(.horizontal)
                .disabled(!pronto)
            }
            
        }
    }
    
}

#Preview {
    BluetoothConnectionView()
}
