//
//  MultiplayerRollView.swift
//  Zonk
//
//  Created by Artur Uvarov on 5/5/24.
//

import SwiftUI


import SwiftUI
import GameKit

struct MultiplayerRollView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var game: MatchManager
    @State private var showMessages = false
    @State private var isChatting = false
    
    var body: some View {
        VStack {
            Text("Real-Time Game")
                .font(.title)
            
            Form {
                Section("Game Data") {
                    // Display the local player's avatar, name, and score.
                    HStack {
                        HStack {
                            game.myAvatar
                                .resizable()
                                .frame(width: 35.0, height: 35.0)
                                .clipShape(Circle())
                            
                            Text(game.myName + " (me)")
                                .lineLimit(2)
                        }
                        Spacer()
                        
                        Text("\(game.myScore)")
                            .lineLimit(2)
                    }
                    
                    // Display the opponent's avatar, name, and score.
                    HStack {
                        HStack {
                            game.opponentAvatar
                                .resizable()
                                .frame(width: 35.0, height: 35.0)
                                .clipShape(Circle())
                            
                            Text(game.opponentName)
                                .lineLimit(2)
                        }
                        Spacer()
                        
                        Text("\(game.opponentScore)")
                            .lineLimit(2)
                    }
                }
                .listItemTint(.blue)
                
                Section("Game Controls") {
                    Button("Take Action") {
                        game.takeAction()
                    }
                    .disabled(game.currentlyRolling ? false : true)

                    Button("End Turn") {
                        game.swapRoles()
                    }
                    .disabled(game.currentlyRolling ? false : true)
                    
                    Button("End Game") {
                        game.endMatch()
                    }
                    
                    Button("Forfeit") {
                        game.forfeitMatch()
                    }
                }
                
            }
        }
        .alert("Game Over", isPresented: $game.youForfeit, actions: {
            Button("OK", role: .cancel) {
                game.resetMatch()
            }
        }, message: {
            Text("You forfeit. Opponent wins.")
        })
        .alert("Game Over", isPresented: $game.opponentForfeit, actions: {
            Button("OK", role: .cancel) {
                // Save the score when the opponent forfeits the game.
                game.saveScore()
                game.resetMatch()
            }
        }, message: {
            Text("Opponent forfeits. You win.")
        })
        .alert("Game Over", isPresented: $game.youWon, actions: {
            Button("OK", role: .cancel) {
                //  Save the score when the local player wins.
                game.saveScore()
                game.resetMatch()
            }
        }, message: {
            Text("You win.")
        })
        .alert("Game Over", isPresented: $game.opponentWon, actions: {
            Button("OK", role: .cancel) {
                game.resetMatch()
            }
        }, message: {
            Text("You lose.")
        })
    }    
}


#Preview {
    MultiplayerRollView(game: MatchManager())
}
