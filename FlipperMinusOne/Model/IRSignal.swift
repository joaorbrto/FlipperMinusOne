//
//  IRSignal.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 04/08/25.
//

import Foundation

struct IRSignal: Codable {
    let `protocol`: String
    let address: Int
    let command: Int

    enum CodingKeys: String, CodingKey {
        case `protocol`
        case address
        case command
    }
}

enum IRCommandPreset: CaseIterable {
    case power, mute, up, down, left, right, ok
    case channelUp, channelDown, volumeUp, volumeDown
    case pause, play
    case _0, _1, _2, _3, _4, _5, _6, _7, _8, _9

    var signal: IRSignal {
        switch self {
        case .power:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x10EF)
        case .mute:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x20DF)
        case .up:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x18E7)
        case .down:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x4AB5)
        case .left:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0xA25D)
        case .right:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0xE21D)
        case .ok:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x22DD)
        case .channelUp:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x00FD)
        case .channelDown:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x807F)
        case .volumeUp:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x40BF)
        case .volumeDown:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0xC03F)
        case .pause:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0xA857)
        case .play:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x6897)
        case ._0:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x00FF)
        case ._1:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x807F)
        case ._2:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x40BF)
        case ._3:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0xC03F)
        case ._4:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x20DF)
        case ._5:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0xA05F)
        case ._6:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x609F)
        case ._7:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0xE01F)
        case ._8:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x10EF)
        case ._9:
            return IRSignal(protocol: "NEC", address: 0x00FF, command: 0x906F)
        }
    }
}
