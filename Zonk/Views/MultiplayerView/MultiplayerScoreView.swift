//
//  MultiplayerScoreView.swift
//  Zonk
//
//  Created by Artur Uvarov on 5/3/24.
//

import SwiftUI

struct MultiplayerScoreView: View {
    @ObservedObject var game: TurnBasedGame
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    HStack {
                        VStack {
                            Text(game.myName)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text("\(game.localParticipant?.score ?? -1)")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding(8)
                        .background(game.myTurn ? Color.green.opacity(0.8) : Color.clear)
                        .cornerRadius(8)
                        
                        VStack {
                            Text(game.opponentName)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("\(game.opponent?.score ?? -1)")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding(8)
                        .background(game.myTurn ? Color.green.opacity(0.8) : Color.clear)
                        .cornerRadius(8)
                    }
                }
                .padding([.bottom], 15)
                
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("Current Player: \(game.localParticipant)")
//                        .foregroundColor(.white)
//                    
//                    Text("Zonks: \(game.localParticipant.zonks)")
//                        .foregroundColor(
//                            game.localParticipant.zonks > 1 ? .red : .white
//                        )
//                    
//                }
//                .font(.subheadline)
//                .fontWeight(.bold)
//                .foregroundColor(.black)
//                
                Text("Current run: \(game.unsavedResult)")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                
                HStack(spacing: 10) {
                    ForEach(game.chosenDices) { dice in
                        DiceView(dice: dice, size: CGSize(width: 30, height: 30))
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .frame(width: 240, height: 200)
        .padding(10)
        .background(Color.green.opacity(0.3))
        .cornerRadius(12)
    }
}

#Preview {
    MultiplayerScoreView(game: TurnBasedGame())
}
