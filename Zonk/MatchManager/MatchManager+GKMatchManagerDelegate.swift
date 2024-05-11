//
//  MatchManager+GKMatchManagerDelegate.swift
//  Zonk
//
//  Created by Artur Uvarov on 5/4/24.
//

import Foundation
import GameKit
import SwiftUI

extension MatchManager: GKMatchDelegate {
    /// Handles a connected, disconnected, or unknown player state.
       /// - Tag:didChange
       func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
           switch state {
           case .connected:
               print("\(player.displayName) Connected")
               
               // For automatch, set the opponent and load their avatar.
               if match.expectedPlayerCount == 0 {
                   opponent = match.players[0]
                   
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
           case .disconnected:
               print("\(player.displayName) Disconnected")
           default:
               print("\(player.displayName) Connection Unknown")
           }
       }
       
       /// Handles an error during the matchmaking process.
       func match(_ match: GKMatch, didFailWithError error: Error?) {
           print("\n\nMatch object fails with error: \(error!.localizedDescription)")
       }

       /// Reinvites a player when they disconnect from the match.
       func match(_ match: GKMatch, shouldReinviteDisconnectedPlayer player: GKPlayer) -> Bool {
           return true
       }
       
       /// Handles receiving a message from another player.
       /// - Tag:didReceiveData
       func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
           // Decode the data representation of the game data.
           let gameData = decode(matchData: data)
           
           switch gameData?.code {
           case "pick":
               unsavedResult = gameData?.unsavedResult ?? 0
               currentRoll = gameData?.currentRoll ?? []
               chosenDices = gameData?.chosenDices ?? []
               
           case "save":
               resetState()
               
               opponentScore = gameData?.score ?? 0
               opponentZonks = 0
               currentlyRolling = true
               
           case "zonk":
               resetState()
               
               opponentScore = gameData?.score ?? 0
               opponentZonks = gameData?.zonks ?? 0               
               currentlyRolling = true
               
           case "message":
               if let text = gameData?.message {
                   // Add the message to the chat view.
                   let message = Message(content: text, playerName: player.displayName, isLocalPlayer: false)
                   messages.append(message)
               }
           default:
               switch gameData?.outcome {
               case "forfeit":
                   opponentForfeit = true
               case "won":
                   youWon = true
               case "lost":
                   opponentWon = true
               default:
                   return
               }
           }
       }
}
