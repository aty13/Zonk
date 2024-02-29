//
//  RollView.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/23/23.
//

import SwiftUI

struct RollView: View {
    @ObservedObject var gameController = GameController()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Score: \(gameController.score)/\(K.winScore)")
                            .font(.title)
                            .foregroundColor(.black)
                        Text("Current run: \(gameController.unsavedResult)")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(.green.opacity(0.3))
                    .cornerRadius(12)
                    Spacer()
                }
                            
                ZStack {
                    Rectangle()
                        .fill(.green.opacity(0.3))
                        .frame(width: 300, height: 50)
                        .cornerRadius(12)
                    
                    HStack {
                        ForEach(gameController.chosenDices) { dice in
                            DiceView(dice: dice, size: CGSize(width: 30, height: 30))
//                                .border(.black)
                        }
                    }
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
                            withAnimation {
                                gameController.roll()
                            }
                            
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
                WinView(gameController: gameController)
            }
        }
    }
}

#Preview {
    RollView()
}
