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
        ZStack {
            VStack {
                GeometryReader { geometry in
                    MultiplayerScoreView(game: game)
                        .padding(.top, -20)
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(game.currentRoll) { dice in
                            DiceView(dice: dice, size: CGSize(width: 80, height: 80))
                                .onTapGesture {
                                    game.handleDiceTap(dice)
                                }
                                .rotationEffect(.degrees(Double.random(in: 0...360)))
                                .padding()
                            
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .padding([.top], 330)
                }
                
                HStack {
                    if game.canSave && game.currentlyRolling {
                        Button {
                            game.saveScore()
                        } label: {
                            Text("Save")
                                .frame(width: 150, height: 70)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .font(.headline)
                                .padding(.trailing, 50)
                        }
                    }
                    
                    if game.canRoll && game.currentlyRolling {
                        Button {
                            game.roll()
                        } label: {
                            Image(systemName: "dice.fill")
                                .font(.system(size: 60))
                                .frame(width: 100, height: 100)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(50)
                        }
                    }
                }
            }
            .background(
                Image("background-roll")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            )
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
        
        if game.zonk {
            ZonkView()
                .onAppear {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        game.itIsZonk()
                    }
                }
        }
    }
}


#Preview {
    let game = MatchManager()
    game.currentlyRolling = true
    
    return MultiplayerRollView(game: game)
}
