//
//  BluetoothManager.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 15/07/25.
//

import CoreBluetooth

// aqui sao os metodos que vao enviar dados do bluetooth

class BLEManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
    var centralManager: CBCentralManager!
    var connectedPeripheral: CBPeripheral?
    var writeCharacteristic: CBCharacteristic?
    
    @Published var discoveredPeripherals: [(peripheral: CBPeripheral, name: String)] = []
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startScanning()
        } else {
            print("Bluetooth não está disponível")
        }
    }
    
    func startScanning() {
        discoveredPeripherals.removeAll()
        centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
        print("🔍 Iniciando busca por dispositivos BLE...")
    }
    
    func stopScanning() {
        centralManager.stopScan()
        print("⛔️ Parando busca por dispositivos BLE")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        let deviceName = advertisementData[CBAdvertisementDataLocalNameKey] as? String ?? peripheral.name ?? "sem nome"
        
        if !discoveredPeripherals.contains(where: { $0.peripheral.identifier == peripheral.identifier }) {
            DispatchQueue.main.async {
                self.discoveredPeripherals.append((peripheral, deviceName))
            }
        }
        
    }
    
    func connectToPeripheral(_ peripheral: CBPeripheral) {
        stopScanning()
        connectedPeripheral = peripheral
        peripheral.delegate = self
        centralManager.connect(peripheral)
        print("🔗 Conectando ao dispositivo: \(peripheral.name ?? "sem nome")")
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("✅ Conectado ao periférico: \(peripheral.name ?? "sem nome")")
        peripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                print("🛠 Serviço encontrado: \(service.uuid)")
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                print("⚙️ Característica encontrada: \(characteristic.uuid)")
                if characteristic.properties.contains(.write) {
                    writeCharacteristic = characteristic
                }
            }
        }
    }
    
    func sendDataToPeripheral(wifiName: String, password: String) {
        guard let characteristic = writeCharacteristic else {
            print("❌ Nenhuma característica disponível para escrita")
            return
        }
        
        let dataString = "\(wifiName)|\(password)"
        if let data = dataString.data(using: .utf8) {
            connectedPeripheral?.writeValue(data, for: characteristic, type: .withResponse)
            print("📤 Dados enviados: \(dataString)")
        }
    }
}

