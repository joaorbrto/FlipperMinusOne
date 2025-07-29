//
//  FlipperCommand.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 29/07/25.
//

import Foundation

enum FlipperCommandType: String, Decodable {
    case jammersDetected    // Flipper → App
    case infraOn            // Flipper → App
    case infraOff           // Flipper → App
    case scanJammers        // App → Flipper
}

struct FlipperCommand: Decodable {
    let command: FlipperCommandType
    let payload: String?
}
