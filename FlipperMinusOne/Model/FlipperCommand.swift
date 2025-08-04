//
//  FlipperCommand.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 29/07/25.
//

import Foundation

struct FlipperCommand: Codable {
    let command: FlipperCommandType
    let payload: String?
}

enum FlipperCommandType: String, Codable {
    case power, mute, number, scanJammers, turnOff
    case up
    case down
    case left
    case right
    case ok
    case channelUp
    case channelDown
    case volumeUp
    case volumeDown
    case pause
    case play
    case brightness
    
    case _0 = "0"
    case _1 = "1"
    case _2 = "2"
    case _3 = "3"
    case _4 = "4"
    case _5 = "5"
    case _6 = "6"
    case _7 = "7"
    case _8 = "8"
    case _9 = "9"
}
