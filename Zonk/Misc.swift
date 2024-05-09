//
//  Misc.swift
//  Zonk
//
//  Created by Artur Uvarov on 5/4/24.
//

import Foundation

enum PlayerAuthState: String {
    case authenticating = "Logging in to the Game Center"
    case unauthenticated = "Please sign in to the Game Center for multiplayer features"
    case authenticated = ""
    
    case error = "Error occured during logging in to the Game Center"
    case restricted = "You're not allowed to play multiplayer games!"
}

struct Move: Identifiable {
    let id = UUID()
    var rolls = [Int]()
    var picks = [Int]()
}
