//
//  MultiplayerScoreView.swift
//  Zonk
//
//  Created by Artur Uvarov on 5/9/24.
//

import SwiftUI

struct MultiplayerScoreView: View {
    @ObservedObject var game: MatchManager
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Menu {
                    Section("Game Controls") {
                        Button("End Game") {
                            game.endMatch()
                        }
                        
                        Button("Forfeit") {
                            game.forfeitMatch()
                        }
                    }
                } label: {
                    Label(
                        title: { Text("Game controls") },
                        icon: { Image(systemName: "chevron.down") }
                    )
                    .foregroundStyle(.white)
                    
                }
                
            }
            HStack {
                HStack {
                    game.myAvatar
                        .resizable()
                        .frame(width: 35.0, height: 35.0)
                        .clipShape(Circle())
                    
                    VStack (alignment: .leading) {
                        Text(game.myName + " (me)")
                            .foregroundStyle(.white)
                        Text("Zonks: \(game.myZonks)")
                            .foregroundStyle(game.myZonks == 2 ? .red : .white)
                            .fontWeight(game.myZonks == 2 ? .heavy : .regular)
                    }
                    
                    
                }
                Spacer()
                
                Text("\(game.myScore)")
                    .foregroundStyle(.white)
            }
            .padding(10)
            .background(game.currentlyRolling ? .blue.opacity(0.9) : .clear)
            .cornerRadius(10)
            
            HStack {
                HStack {
                    game.opponentAvatar
                        .resizable()
                        .frame(width: 35.0, height: 35.0)
                        .clipShape(Circle())
                    
                    VStack (alignment: .leading) {
                        Text(game.opponentName)
                            .foregroundStyle(.white)
                        Text("Zonks: \(game.opponentZonks)")
                            .foregroundStyle(game.opponentZonks == 2 ? .red : .white)
                            .fontWeight(game.opponentZonks == 2 ? .heavy : .regular)
                    }
                }
                Spacer()
                
                Text("\(game.opponentScore)")
                    .foregroundStyle(.white)
            }
            .padding(10)
            .background(!game.currentlyRolling ? .blue.opacity(0.9) : .clear)
            .cornerRadius(10)
            
            HStack {

                Text("Current run: \(game.unsavedResult)")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                
                Spacer()
            }
            
            HStack(spacing: 10) {
                ForEach(game.chosenDices) { dice in
                    DiceView(dice: dice, size: CGSize(width: 30, height: 30))
                    
                }
                Spacer()
            }
            .frame(minHeight: 30)
        }
        .padding()
        .background(.blue.opacity(0.3))
        .cornerRadius(10)
        .padding()
        
        
    }
}

#Preview {
    let game = MatchManager()
    game.currentlyRolling = true
    
    return MultiplayerRollView(game: game)
}
