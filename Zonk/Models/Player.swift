//
//  Player.swift
//  Zonk
//
//  Created by Artur Uvarov on 2/20/24.
//

import Foundation

struct Player: Identifiable {
    let id = UUID()
    let name: String
    var score: Int = 0
    var zonks: Int = 0
    let ai: Bool
    
    mutating func reset() {
        self.score = 0
    }
}
