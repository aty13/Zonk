//
//  ScoreView.swift
//  Zonk
//
//  Created by Artur Uvarov on 4/14/24.
//

import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var gameController: GameController
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    if gameController.players.count > 3 {
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 20) {
                                ForEach(gameController.players.indices.prefix(3), id: \.self) { index in
                                    playerView(for: index)
                                }
                            }
                            HStack(spacing: 20) {
                                ForEach(gameController.players.indices.dropFirst(3), id: \.self) { index in
                                    playerView(for: index)
                                }
                            }
                        }
                    } else {
                        
                        HStack(spacing: 20) {
                            ForEach(gameController.players.indices, id: \.self) { index in
                                playerView(for: index)
                            }
                        }
                    }
                }
                .padding([.bottom], 15)
                            
                
                VStack(alignment: .leading, spacing: 0) {
                    if gameController.players.count > 1 {
                        Text("Current Player: \(gameController.players[gameController.currentPlayerIndex].name)")
                            .foregroundColor(.white)
                    }
                    Text("Zonks: \(gameController.players[gameController.currentPlayerIndex].zonks)")
                        .foregroundColor(
                            gameController.players[gameController.currentPlayerIndex].zonks > 1 ? .red : .white
                        )
                    
                }
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                
                Text("Current run: \(gameController.unsavedResult)")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                
                HStack(spacing: 10) {
                    ForEach(gameController.chosenDices) { dice in
                        DiceView(dice: dice, size: CGSize(width: 30, height: 30))
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .frame(width: 240, height: gameController.players.count < 4 ? 175 : 200)
        .padding(10)
        .background(Color.green.opacity(0.3))
        .cornerRadius(12)
    }
    
    private func playerView(for index: Int) -> some View {
        let player = gameController.players[index]
        return VStack {
            Text(player.name)
                .font(.headline)
                .foregroundColor(.white)
            Text("\(player.score)")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(8)
        .background(index == gameController.currentPlayerIndex ? Color.green.opacity(0.8) : Color.clear)
        .cornerRadius(8)
    }
}

#Preview {
    let gameController = GameController()
//    gameController.players.append(Player(name: "Aty", ai: false))
//    gameController.players.append(Player(name: "Igor", ai: false))
//    gameController.players.append(Player(name: "Vika", ai: false))
//    gameController.players.append(Player(name: "Petro", ai: false))
//    gameController.players.append(Player(name: "Petro", ai: false))
    
    return RollView()
        .environmentObject(gameController)
    
    
    
}
