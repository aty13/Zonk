//
//  MatchManager.swift
//  Zonk
//
//  Created by Artur Uvarov on 5/4/24.
//

import Foundation
import GameKit
import SwiftUI

/// - Tag:RealTimeGame
@MainActor
class MatchManager: NSObject, ObservableObject {
    // The local player's friends, if they grant access.
    //    @Published var friends: [Friend] = []
    
    // The game interface state.
    @Published var authenticationState = PlayerAuthState.authenticating
    @Published var matchAvailable = false
    @Published var playingGame = false
    @Published var myMatch: GKMatch? = nil
    @Published var automatch = false
    
    // Outcomes of the game for notifing players.
    @Published var youForfeit = false
    @Published var opponentForfeit = false
    @Published var youWon = false
    @Published var opponentWon = false
    
    // Current turn at local
    @Published var currentlyRolling = false
    
    
    // The match information.
    @Published var myAvatar = Image(systemName: "person.crop.circle")
    @Published var opponentAvatar = Image(systemName: "person.crop.circle")
    @Published var opponent: GKPlayer? = nil
    @Published var messages: [Message] = []
    @Published var myScore = 0
    @Published var myZonks = 0
    @Published var opponentScore = 0
    @Published var opponentZonks = 0
    
    // Zonk props
    @Published var winScore: Int = 10000
    @Published var dicesAmount: Int = 6
    @Published var canRoll: Bool = true
    @Published var canSave: Bool = false
    @Published var zonk: Bool = false
    @Published var currentTriplets: [Dice] = []
    @Published var chosenDicesShort: [Dice] = []
    
    @Published var unsavedResult: Int = 0
    @Published var currentRoll: [Dice] = []
    @Published var chosenDices: [Dice] = []
    
    /// The name of the match.
    var matchName: String {
        "\(opponentName) Match"
    }
    
    /// The local player's name.
    var myName: String {
        GKLocalPlayer.local.displayName
    }
    
    /// The local player's id.
    var myId: String {
        GKLocalPlayer.local.teamPlayerID
    }
    
    /// The opponent's name.
    var opponentName: String {
        opponent?.displayName ?? "Invitation Pending"
    }
    
    /// The opponent's id.
    var opponentId: String {
        opponent?.teamPlayerID ?? "null"
    }
    
    /// The root view controller of the window.
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    /// Authenticates the local player, initiates a multiplayer game, and adds the access point.
    /// - Tag:authenticatePlayer
    func authenticatePlayer() {
        // Set the authentication handler that GameKit invokes.
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                // If the view controller is non-nil, present it to the player so they can
                // perform some necessary action to complete authentication.
                self.rootViewController?.present(viewController, animated: true) { }
                return
            }
            if let error {
                self.authenticationState = .error
                
                // If you can’t authenticate the player, disable Game Center features in your game.
                print("Error: \(error.localizedDescription).")
                return
            }
            
            if GKLocalPlayer.local.isAuthenticated {
                if GKLocalPlayer.local.isMultiplayerGamingRestricted {
                    self.authenticationState = .restricted
                } else {
                    self.authenticationState = .authenticated
                }
            } else {
                self.authenticationState = .unauthenticated
            }
            
            // A value of nil for viewController indicates successful authentication, and you can access
            // local player properties.
            
            // Load the local player's avatar.
            GKLocalPlayer.local.loadPhoto(for: GKPlayer.PhotoSize.small) { image, error in
                if let image {
                    self.myAvatar = Image(uiImage: image)
                }
                if let error {
                    // Handle an error if it occurs.
                    print("Error: \(error.localizedDescription).")
                }
            }
            
            // Register for real-time invitations from other players.
            GKLocalPlayer.local.register(self)
            
            // Add an access point to the interface.
            /// TODO: return later
            //            GKAccessPoint.shared.location = .topLeading
            //            GKAccessPoint.shared.showHighlights = true
            //            GKAccessPoint.shared.isActive = true
            //
            
            // Enable the Start Game button.
            self.matchAvailable = true
        }
    }
    
    /// Starts the matchmaking process where GameKit finds a player for the match.
    /// - Tag:findPlayer
    func findPlayer() async {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        let match: GKMatch
        
        // If you use matchmaking rules, set the GKMatchRequest.queueName property here. If the rules use
        // game-specific properties, set the local player's GKMatchRequest.properties too.
        
        // Start automatch.
        do {
            match = try await GKMatchmaker.shared().findMatch(for: request)
        } catch {
            print("Error: \(error.localizedDescription).")
            return
        }
        
        // Start the game, although the automatch player hasn't connected yet.
        if !playingGame {
            startMyMatchWith(match: match)
        }
        
        // Stop automatch.
        GKMatchmaker.shared().finishMatchmaking(for: match)
        automatch = false
    }
    
    /// Presents the matchmaker interface where the local player selects and sends an invitation to another player.
    /// - Tag:choosePlayer
    func choosePlayer() {
        // Create a match request.
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        // If you use matchmaking rules, set the GKMatchRequest.queueName property here. If the rules use
        // game-specific properties, set the local player's GKMatchRequest.properties too.
        
        // Present the interface where the player selects opponents and starts the game.
        if let viewController = GKMatchmakerViewController(matchRequest: request) {
            viewController.matchmakerDelegate = self
            rootViewController?.present(viewController, animated: true) { }
        }
    }
    
    // Starting and stopping the game.
    
    /// Starts a match.
    /// - Parameter match: The object that represents the real-time match.
    /// - Tag:startMyMatchWith
    func startMyMatchWith(match: GKMatch) {
        GKAccessPoint.shared.isActive = false
        playingGame = true
        myMatch = match
        myMatch?.delegate = self
        
        // For automatch, check whether the opponent connected to the match before loading the avatar.
        if myMatch?.expectedPlayerCount == 0 {
            opponent = myMatch?.players[0]
            
            // Load the opponent's avatar.
            opponent?.loadPhoto(for: GKPlayer.PhotoSize.small) { (image, error) in
                if let image {
                    self.opponentAvatar = Image(uiImage: image)
                }
                if let error {
                    print("Error: \(error.localizedDescription).")
                }
            }
        }
        
        currentlyRolling = myId < opponentId
        
        // Increment the achievement to play 10 games.
    }
    
    /// - Tag: Rolled
    func rollOrDiceTapped() {
        
        do {
            let data = encode(
                unsavedResult: unsavedResult,
                currentRoll: currentRoll,
                chosenDices: chosenDices
            )
            
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    /// - Tag: Save tapped
    func saveButtonTapped() {
        
        do {
            let data = encode(
                score: myScore, nextPlayer: true
            )
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
            
            currentlyRolling = !currentlyRolling
            
            resetState()
            
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    /// Zonk!
    func zonkHappened() {
        do {
            let data = encode(
                score: myScore, nextPlayer: true, zonks: myZonks
            )
            
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
            
            currentlyRolling = !currentlyRolling
            
            resetState()
            
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    /// Quits a match and saves the game data.
    /// - Tag:endMatch
    func endMatch() {
        let myOutcome = myScore >= opponentScore ? "won" : "lost"
        let opponentOutcome = opponentScore > myScore ? "won" : "lost"
        
        // Notify the opponent that they won or lost, depending on the score.
        do {
            let data = encode(outcome: opponentOutcome)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
        
        // Notify the local player that they won or lost.
        if myOutcome == "won" {
            youWon = true
        } else {
            opponentWon = true
        }
    }
    
    /// Forfeits a match without saving the score.
    /// - Tag:forfeitMatch
    func forfeitMatch() {
        // Notify the opponent that you forfeit the game.
        do {
            let data = encode(outcome: "forfeit")
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
        
        youForfeit = true
    }
    
    /// Saves the local player's score.
    /// - Tag:saveScore
    func saveScoreToLeaderboard() {
        GKLeaderboard.submitScore(
            unsavedResult,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: ["top_score_one_turn"]
        ) { error in
            if let error {
                print("Error: \(error.localizedDescription).")
            }
        }
    }
    
    /// Resets a match after players reach an outcome or cancel the game.
    func resetMatch() {
        // Reset the game data.
        playingGame = false
        myMatch?.disconnect()
        myMatch?.delegate = nil
        myMatch = nil
        opponent = nil
        opponentAvatar = Image(systemName: "person.crop.circle")
        messages = []
        GKAccessPoint.shared.isActive = true
        youForfeit = false
        opponentForfeit = false
        youWon = false
        opponentWon = false
        
        // Reset the score.
        myScore = 0
        opponentScore = 0
    }
    
    /// Reset state after player makes a move
    func resetState() {
        currentRoll = []
        chosenDices = []
        chosenDicesShort = []
        unsavedResult = 0
    }
}
