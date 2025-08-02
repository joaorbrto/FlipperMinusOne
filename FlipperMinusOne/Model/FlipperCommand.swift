//
//  FlipperCommand.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 29/07/25.
//

import Foundation

enum FlipperCommandType: String, Codable {
    case jammersDetected    // Flipper → App
    case power, mute, up, down, left, right, ok
    case channelUp, channelDown, volumeUp, volumeDown
    case number
    case pause, play, brightness      // Flipper → App
    case scanJammers        // App → Flipper
}


struct FlipperCommand: Codable {
    let command: FlipperCommandType
    let payload: String?
}
