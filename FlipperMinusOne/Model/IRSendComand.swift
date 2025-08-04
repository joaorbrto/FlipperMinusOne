//
//  IRSendComand.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 04/08/25.
//

import Foundation

struct IRSendCommand: Codable {
    let protocolName: String
    let address: Int
    let command: Int

    enum CodingKeys: String, CodingKey {
        case protocolName = "protocol"
        case address
        case command
    }
}
