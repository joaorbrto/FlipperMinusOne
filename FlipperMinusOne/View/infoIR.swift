//
//  infoIR.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/08/25.
//

import SwiftUI

struct infoIR: View {
    @Binding var isPresented: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack {
                    Color.infoback
                        .ignoresSafeArea()
                    
                    Image("IRCommand")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 160)
                }
                .frame(width: 400, height: 181)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Group {
                            Text("Saiba mais sobre o infravermelho (IR)")
                                .font(.title)
                                .bold()
                            
                            Text("Como funciona um infravermelho?")
                                .font(.title2)
                                .bold()
                            
                            Text("Pense no infravermelho (IR) como uma forma de luz que nossos olhos não conseguem ver. Assim como a luz visível ou as ondas de rádio, o IR é uma onda eletromagnética, mas com uma frequência um pouco mais baixa que a da luz vermelha.")
                            
                            Text("Qualquer objeto que gera calor emite radiação IR. Seu corpo, o sol e, claro, o controle remoto da sua TV estão constantemente emitindo essa energia invisível.")
                            
                            Text("Para a comunicação, como em controles remotos, usamos o infravermelho próximo. Ele é perfeito para transmitir dados a curta distância de forma rápida e segura.")
                            
                            Text("No FlippEdu, usamos essa luz invisível para enviar e receber comandos, transformando seu celular em um controle remoto universal.")
                        }
                        
                        Group {
                            Text("Como funciona a comunicação?")
                                .font(.title2)
                                .bold()
                            
                            Text("A mágica da comunicação IR acontece com uma dupla dinâmica: um emissor e um receptor.")
                            
                            Text("• Emissor IR (LED TSAL6200): Uma lanterna especial.\n• Receptor IR (Sensor TSOP4838): Um olho sempre observando sinais.")
                            
                            Text("Este não é um LED comum. Ele pisca em uma velocidade altíssima (em uma frequência de 38 kHz) para criar um código de luz. Cada piscada e pausa representa os intervalos de 0s e 1s de um comando digital.")
                            
                            Text("Quando você aperta um botão no app, o ESP32 aciona este LED para ele piscar o código exato que foi gravado, como se fosse o controle original.")
                            
                            Text("O Receptor IR (TSOP4838) detecta apenas a luz que pisca na frequência de 38 kHz, ignorando outras fontes de luz ambiente como o sol ou lâmpadas. Ele converte isso em sinal elétrico para o ESP32.")
                        }
                        
                        Group {
                            Text("Por que os sinais são modulados?")
                                .font(.title2)
                                .bold()
                            
                            Text("• Evita interferências: garante que a luz do sol ou de uma lâmpada não seja confundida com um comando.\n• Garante foco: o receptor presta atenção apenas aos sinais importantes.\n• Aumenta o alcance: sinais modulados viajam mais longe e com mais clareza.")
                            
                            Text("Protocolos")
                                .font(.title2)
                                .bold()
                            
                            Text("Para que um controle da Sony não ligue uma TV da Samsung por acidente, os dispositivos usam protocolos. Pense neles como idiomas diferentes que organizam como os 0s e 1s são transmitidos.")
                            
                            Text("Protocolos mais comuns:\n• NEC\n• Sony SIRC\n• RC-5 (Philips)\n• Samsung, LG e outros")
                            
                            Text("O superpoder do FlippEdu é que ele não precisa entender o protocolo. O ESP32 grava o padrão de piscadas (o sinal bruto) e o reproduz com perfeição.")
                        }
                        
                        Group {
                            Text("Aplicações do IR")
                                .font(.title2)
                                .bold()
                            
                            Text("• Controles remotos de TVs, home theaters e projetores\n• Climatizadores e ar-condicionados\n• Sensores de presença\n• Brinquedos controlados\n• Automação residencial")
                            
                            Text("O FlippEdu usa essa tecnologia acessível para criar uma ferramenta poderosa para o usuário final.")
                        }
                        
                        Group {
                            Text("FlippEdu em ação!")
                                .font(.title2)
                                .bold()
                            
                            Text("Passo 1: Modo Receptor")
                                .font(.subheadline).bold()
                            
                            Text("1. Aponte o controle remoto para o Flipper Minus One\n2. Pressione um botão\n3. O sensor TSOP4838 capta os pulsos IR\n4. O ESP32 traduz e salva o código\n5. O comando aparece no app")
                            
                            Text("Passo 2: Modo Emissor")
                                .font(.subheadline).bold()
                            
                            Text("1. Você seleciona um comando salvo no app\n2. O app envia a ordem para o ESP32 via Bluetooth\n3. O ESP32 aciona o LED TSAL6200\n4. O LED reproduz o código IR e o aparelho é controlado")
                            
                            Text("Componentes principais:\n• ESP32: cérebro do sistema\n• TSOP4838: ouvido que escuta os sinais\n• TSAL6200: boca que envia os sinais\n• MOSFET: amplifica o alcance do LED emissor")
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                }
            }
            .background(Color.colorback.ignoresSafeArea())
            .navigationTitle("Artigo sobre Infravermelho")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK") {
                        isPresented = false
                    }
                    .foregroundColor(.orange)
                    .bold()
                }
            }
        }
    }
}
