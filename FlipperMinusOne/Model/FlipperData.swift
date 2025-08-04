//
//  FlipperData.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 10/07/25.
//

import Foundation

struct FlipperData: Decodable {
    let name: String
    let status: String
    let message: String
}

enum FlipperMode: String, Codable {
    case ir, jammer, off
}

struct ModeMessage: Codable {
    let mode: FlipperMode
}
