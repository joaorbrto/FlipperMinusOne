//
//  FlipperCommand.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 29/07/25.
//

import Foundation

enum FlipperCommandType: String, Codable {
    case jammersDetected
    case power, mute, up, down, left, right, ok
    case channelUp, channelDown, volumeUp, volumeDown
    case number
    case pause, play, brightness
    case scanJammers
}

struct FlipperCommand: Codable {
    let command: FlipperCommandType
    let payload: String?
}

extension FlipperCommand {
    var mqttTopic: String {
        switch command {
        case .scanJammers, .jammersDetected:
            return "flippedu/jammer"
        default:
            return "flippedu/ir"
        }
    }
}
