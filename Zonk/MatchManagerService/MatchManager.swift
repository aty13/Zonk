//
//  MatchManager.swift
//  Zonk
//
//  Created by Artur Uvarov on 5/4/24.
//

import Foundation
import GameKit

class MatchManager: NSObject, ObservableObject {
    @Published var inMatch = false
    @Published var isGameOver = false
    @Published var authenticationState = PlayerAuthState.authenticating
    
    @Published var currentlyRolling = false
    @Published var lastMoves = [Move]()
    
    var match: GKMatch?
    var localPlayer = GKLocalPlayer.local
    var remotePlayer: GKPlayer?
    
    var playerUUIDKey = UUID().uuidString
    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { [self] vc, e in
            if let viewController = vc {
                rootViewController?.present(viewController, animated: true)
                
                return
            }
            
            if let error = e {
                authenticationState = .error
                print(error.localizedDescription)
                
                return
            }
            
            if localPlayer.isAuthenticated {
                if localPlayer.isMultiplayerGamingRestricted {
                    authenticationState = .resticted
                } else {
                    authenticationState = .authenticated
                }
            } else {
                authenticationState = .unauthenticated
            }
        }
    }
    
    func startMatchmaking() {
        let request = GKMatchRequest()
        
        request.minPlayers = 2
        request.maxPlayers = 2
        
        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
        
        matchmakingVC?.matchmakerDelegate = self
        
        rootViewController?.present(matchmakingVC!, animated: true)
    }
    
    func startMatch(newMatch: GKMatch) {
        match = newMatch
        match?.delegate = self
        remotePlayer = match?.players.first
        
        sendString("began: \(playerUUIDKey)")
    }
    
    func receivedString(_ message: String) {
        let messageSplit = message.split(separator: ":")
        
        guard let prefix = messageSplit.first else { return }
        
        let parameter = String(messageSplit.last ?? "")
        
        switch prefix {
        case "began":
            if playerUUIDKey == parameter {
                playerUUIDKey = UUID().uuidString
                sendString("began:\(playerUUIDKey)")
                break
            }
            
            inMatch = true
            currentlyRolling = true
            
        default:
            break
        }
    }
}
