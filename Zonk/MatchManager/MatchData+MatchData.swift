//
//  MatchData+MatchData.swift
//  Zonk
//
//  Created by Artur Uvarov on 5/7/24.
//

import Foundation
import GameKit
import SwiftUI

// MARK: Game Data Objects
struct GameData: Codable {
    var code: String?
    var matchName: String
    var playerName: String
    var nextPlayer: Bool?
    var score: Int?
    var message: String?
    var outcome: String?
    var unsavedResult: Int?
    var currentRoll: [Dice]?
    var chosenDices: [Dice]?
    var zonks: Int?
}

extension MatchManager {
    
    // MARK: Codable Game Data
    
    /// Creates a data representation of the local player's score for sending to other players.
    ///
    
    /// - Returns: Game data with current Game state
    func encode(unsavedResult: Int, currentRoll: [Dice], chosenDices: [Dice]) -> Data? {
        let gameData = GameData(
            code: "pick",
            matchName: matchName,
            playerName: GKLocalPlayer.local.displayName,
            nextPlayer: true,
            score: nil,
            message: nil,
            outcome: nil,
            unsavedResult: unsavedResult,
            currentRoll: currentRoll,
            chosenDices: chosenDices,
            zonks: nil
        )
        
        return encode(gameData: gameData)
    }
    
    /// - Returns: A representation of game data that contains the score and next player flag.
    func encode(score: Int, nextPlayer: Bool) -> Data? {
        let gameData = GameData(
            code: "save",
            matchName: matchName,
            playerName: GKLocalPlayer.local.displayName,
            score: score,
            message: nil,
            outcome: nil
        )
        return encode(gameData: gameData)
    }
    
    /// - Returns: A representation of game data that contains the score and next player flag.
    func encode(score: Int, nextPlayer: Bool, zonks: Int) -> Data? {
        let gameData = GameData(
            code: "zonk",
            matchName: matchName,
            playerName: GKLocalPlayer.local.displayName,
            nextPlayer: true,
            score: score,
            message: nil,
            outcome: nil,
            zonks: zonks
        )
        return encode(gameData: gameData)
    }
    
    /// Creates a data representation of a text message for sending to other players.
    ///
    /// - Parameter message: The message that the local player enters.
    /// - Returns: A representation of game data that contains only a message.
    func encode(message: String?) -> Data? {
        let gameData = GameData(
            code: "message",
            matchName: matchName,
            playerName: GKLocalPlayer.local.displayName,
            score: nil,
            message: message,
            outcome: nil
        )
        return encode(gameData: gameData)
    }
    
    /// Creates a data representation of the game outcome for sending to other players.
    ///
    /// - Returns: A representation of game data that contains only the game outcome.
    func encode(outcome: String) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, score: nil, message: nil, outcome: outcome)
        return encode(gameData: gameData)
    }
    
    /// Creates a data representation of game data for sending to other players.
    ///
    /// - Returns: A representation of game data.
    func encode(gameData: GameData) -> Data? {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(gameData)
            return data
        } catch {
            print("Error: \(error.localizedDescription).")
            return nil
        }
    }
    
    /// Decodes a data representation of match data from another player.
    ///
    /// - Parameter matchData: A data representation of the game data.
    /// - Returns: A game data object.
    func decode(matchData: Data) -> GameData? {
        // Convert the data object to a game data object.
        return try? PropertyListDecoder().decode(GameData.self, from: matchData)
    }
}
