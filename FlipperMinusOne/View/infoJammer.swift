//
//  infoJammer.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 02/08/25.
//

import SwiftUI

struct infoJammer: View {
    @Binding var isPresented: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack {
                    Color.infoback
                        .ignoresSafeArea()

                    Image("JammerDetect")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 160)
                }
                .frame(width: 400, height: 181)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Group {
                            Text("Saiba mais sobre o Jammer")
                                .font(.title)
                                .bold()

                            Text("O que é um Jammer?")
                                .font(.title2)
                                .bold()

                            Text("Um Jammer é um dispositivo que bloqueia sinais de comunicação sem fio, como celular, Wi-Fi, GPS e Bluetooth. Ele interfere nessas conexões, impedindo que os dispositivos se comuniquem entre si.")

                            Text("Como um Jammer funciona?")
                                .font(.title2)
                                .bold()

                            Text("O Jammer transmite um sinal forte na mesma frequência que outros dispositivos usam. Esse sinal causa interferência, tornando impossível a troca de dados. É como tentar conversar com alguém em meio a muito barulho.")
                        }

                        Group {
                            Text("Protocolos afetados")
                                .font(.title2)
                                .bold()

                            Text("Jammers podem afetar diferentes tipos de sinal:\n• Celular (GSM, 3G, 4G, 5G)\n• GPS\n• Bluetooth\n• Rádio e satélite\n\nCada tipo de Jammer opera em frequências específicas.")

                            Text("Onde são usados e para que servem?")
                                .font(.title2)
                                .bold()

                            Text("Jammers podem ser encontrados em ambientes como:\n• Prisões, para bloquear celulares de detentos\n• Locais de provas, para evitar fraudes\n• Áreas militares, para segurança e contraespionagem\n• Ambientes silenciosos, como salas de cinema ou templos (em alguns países)")
                        }

                        Group {
                            Text("Como funciona um detector de Jammer?")
                                .font(.title2)
                                .bold()

                            Text("Detectores de Jammer monitoram o espectro de frequências em busca de interferências fora do padrão. Quando detectam sinais contínuos, fortes e sem identificação válida, eles alertam que pode haver um Jammer na área. Alguns detectores também localizam a origem da interferência.")

                            Text("Ilegalidade e riscos")
                                .font(.title2)
                                .bold()

                            Text("No Brasil, a venda e o uso de Jammers sem autorização são proibidos por lei.\n\nO uso de bloqueadores de sinal é proibido por diversas razões. Eles podem impedir chamadas de emergência, interferir no funcionamento de hospitais, aviões e serviços públicos essenciais, além de causar acidentes e prejuízos significativos.")

                            Text("Jammers são ferramentas poderosas, mas devem ser usados com responsabilidade e dentro da lei. O uso sem autorização coloca vidas em risco e traz consequências legais sérias.")
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                }
            }
            .background(Color.colorback.ignoresSafeArea())
            .navigationTitle("Artigo sobre Jammer")
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
