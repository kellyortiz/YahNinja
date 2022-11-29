//
//  Types.swift
//  YahNinja
//
//  Created by Kelly Ortiz Figueiredo on 25/11/22.
//

import Foundation

struct PhysicsCategory {
    static let Player: UInt32 = 0b1
    static let Wall: UInt32 = 0b10
    static let Score: UInt32 = 0b100
}

public let fontNamed = "Krungthep"

enum GameState: Int {
    case initial = 0, start, play, dead
}
