//
//  RollView.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/23/23.
//

import SwiftUI

struct RollView: View {
    @EnvironmentObject var gameController: GameController
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        HStack(spacing: 20) {
                            ForEach(gameController.players.indices, id: \.self) { index in
                                let player = gameController.players[index]
                                VStack {
                                    Text(player.name)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Text("\(player.score)/\(gameController.winScore)")
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                }
                                .padding(8)
                                .background(index == gameController.currentPlayerIndex ? Color.green.opacity(0.3) : Color.clear) // Highlight current player
                                .cornerRadius(8)
                            }
                        }
                        .padding([.bottom], 15)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Current Player: \(gameController.players[gameController.currentPlayerIndex].name)")
                            
                        }
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        
                        Text("Current run: \(gameController.unsavedResult)")
                            .font(.title2)
                            .foregroundColor(.black)
                        
                        HStack(spacing: 10) {
                            ForEach(gameController.chosenDices) { dice in
                                DiceView(dice: dice, size: CGSize(width: 30, height: 30))
                            }
                        }
                    }
                    .padding(15)
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(12)
                    
                    Spacer()
                }
            
        
                
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(gameController.currentRoll) { dice in
                        DiceView(dice: dice, size: CGSize(width: 100, height: 100))
                            .onTapGesture {
                                gameController.handleDiceTap(dice)
                            }
                            .rotationEffect(.degrees(Double.random(in: 0...360)))
                            .padding()
                    }
                }
                .padding([.top], 150)
                .frame(maxHeight: 300)
                
                Spacer()
                
                HStack {
                    if gameController.canSave {
                        Button {
                                gameController.saveScore()
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
                    
                    if gameController.canRoll {
                        Button {
                                gameController.roll()
                            
                        } label: {
                            Image(systemName: "dice.fill")
                                .font(.system(size: 60))
                                .frame(width: 100, height: 100)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(50)
                        }
                    }
                }
                
                
            }
            .padding()
            .background(
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            )
            
            if gameController.zonk {
                ZonkView()
                    .onAppear {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                gameController.itIsZonk()
                        }
                    }
            }
            
            if gameController.win {
                WinView()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    RollView()
        .environmentObject(GameController())
}
