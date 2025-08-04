//
//  MQTTManager.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 10/07/25.
//

import Foundation
import CocoaMQTT

final class MQTTManager: ObservableObject {

    static let shared = MQTTManager()

    @Published var receivedData: FlipperData?
    @Published var receivedCommand: FlipperCommand?
    @Published var isConnected: Bool = false
    @Published var isJammerDetected: Bool = false
    @Published var deviceName: String = ""

    private var mqttClient: CocoaMQTT?
    @Published var lastIRSignal: IRSignal?

    private var host: String = ""
    private var port: UInt16 = 1883
    private var subscribeTopic: String = ""
    private var publishTopic: String = ""

    // MARK: - Configuração dinâmica
    public func configureMQTT(
        host: String,
        port: UInt16,
        subscribeTopic: String,
        publishTopic: String
    ) {
        self.host = host
        self.port = port
        self.subscribeTopic = subscribeTopic
        self.publishTopic = publishTopic

        let clientID = "FlipperClient-\(UUID().uuidString.prefix(6))"
        mqttClient = CocoaMQTT(clientID: clientID, host: host, port: port)
        mqttClient?.keepAlive = 60
        mqttClient?.delegate = self
        mqttClient?.connect()
    }

    // MARK: - Enviar modo separadamente
    func sendMode(_ mode: FlipperMode) {
        let modeMessage = ModeMessage(mode: mode)
        do {
            let data = try JSONEncoder().encode(modeMessage)
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📤 Enviando modo para \(publishTopic): \(jsonString)")
                mqttClient?.publish(publishTopic, withString: jsonString, qos: .qos1)
            }
        } catch {
            print("❌ Erro ao codificar modo: \(error)")
        }
    }

    // MARK: - Enviar comando separadamente
    func sendCommand(_ type: FlipperCommandType, payload: String? = nil) {
        let command = FlipperCommand(command: type, payload: payload)

        do {
            let data = try JSONEncoder().encode(command)
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📤 Enviando comando para \(publishTopic): \(jsonString)")
                mqttClient?.publish(publishTopic, withString: jsonString, qos: .qos1)
            }
        } catch {
            print("❌ Erro ao codificar comando: \(error)")
        }
    }

    func publish(message: String, topic: String) {
        mqttClient?.publish(topic, withString: message, qos: .qos1)
    }

    func disconnect() {
        mqttClient?.disconnect()
        isConnected = false
    }

    func sendIRSignal(_ signal: IRSignal) {
        do {
            let data = try JSONEncoder().encode(signal)
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📤 Enviando IR: \(jsonString)")
                publish(message: jsonString, topic: "flippedu/ir")
                DispatchQueue.main.async {
                    self.lastIRSignal = signal // agora publicado
                }
            }
        } catch {
            print("❌ Erro ao codificar sinal IR: \(error)")
        }
    }

    func sendIRPreset(_ preset: IRCommandPreset) {
        let signal = preset.signal
        sendIRSignal(signal)
    }
    func sendRetransmitCommand() {
        let retransmitJSON = #"{"command":"retransmit"}"#
        print("🔁 Enviando retransmissão: \(retransmitJSON)")
        publish(message: retransmitJSON, topic: "flippedu/ir")
    }
}

extension MQTTManager: CocoaMQTTDelegate {

    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        if ack == .accept {
            print("✅ Conectado ao broker MQTT!")
            mqtt.subscribe(subscribeTopic)

            DispatchQueue.main.async {
                self.isConnected = true
            }
        } else {
            print("❌ Falha ao conectar: \(ack)")
        }
    }

    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        guard let jsonString = message.string else { return }
        print("📩 Mensagem recebida: \(jsonString)")

        if let jammer = try? JSONDecoder().decode(JammerStatus.self, from: Data(jsonString.utf8)) {
            DispatchQueue.main.async {
                self.isJammerDetected = jammer.jammer_detected
                print("🚨 Jammer detectado: \(jammer.jammer_detected)")
            }
        } else if let command = try? JSONDecoder().decode(FlipperCommand.self, from: Data(jsonString.utf8)) {
            DispatchQueue.main.async {
                self.receivedCommand = command
            }
        } else if let data = jsonString.data(using: .utf8),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  dict["command"] as? String == "retransmit" {
            if let last = lastIRSignal {
                print("🔁 Reenviando último IR")
                sendIRSignal(last)
            } else {
                print("⚠️ Nenhum comando IR anterior para retransmitir.")
            }
        } else {
            print("⚠️ Mensagem não reconhecida.")
        }
    }

    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics topics: [String]) {
        print("🔗 Inscrito nos tópicos: \(topics)")
    }

    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        print("🔌 Cancelou inscrição nos tópicos: \(topics)")
    }

    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("⚠️ Desconectado: \(err?.localizedDescription ?? "Sem erro")")
        DispatchQueue.main.async {
            self.isConnected = false
        }
    }

    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("📤 Mensagem publicada: \(message.string ?? "Sem conteúdo")")
    }

    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("✅ Publicação confirmada para ID \(id)")
    }

    func mqtt(_ mqtt: CocoaMQTT, didStateChangeTo state: CocoaMQTTConnState) {
        print("🔄 Estado da conexão: \(state)")
    }

    func mqtt(_ mqtt: CocoaMQTT, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }

    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("📡 Ping enviado.")
    }

    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print("🏓 Pong recebido.")
    }

    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        if !failed.isEmpty {
            print("❌ Falha ao se inscrever: \(failed)")
        }
        if success.count > 0 {
            print("✅ Inscrito com sucesso: \(success)")
        }
    }
}
