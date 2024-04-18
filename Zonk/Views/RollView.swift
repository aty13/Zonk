//
//  RollView.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/23/23.
//

import SwiftUI

struct RollView: View {
    @EnvironmentObject var gameController: GameController
    @Environment(\.dismiss) private var dismiss
    @State private var isRestartPresentingConfirm: Bool = false
    @State private var isQuitPresentingConfirm: Bool = false
    @State var isWinViewShowing: Bool = false
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                HStack {
                    HStack(alignment: .top) {

                        ScoreView()
                        
                        Spacer()
                        
                        HStack {
                            TopButton(
                                isPresentingConfirm: $isRestartPresentingConfirm,
                                systemImageName: "gobackward",
                                confirmationTitleText: "You sure you want to restart?",
                                confirmationButtonText: "Restart",
                                buttonAction: {
                                    gameController.restart()
                                }
                            )
                            
                            TopButton(
                                isPresentingConfirm: $isQuitPresentingConfirm,
                                systemImageName: "backward.frame",
                                confirmationTitleText: "You sure you want to quit?",
                                confirmationButtonText: "Quit",
                                buttonAction: {
                                    gameController.restart()
                                    dismiss()
                                }
                                
                            )
                            
                        }
                        .padding(15)
                        .background(Color.green.opacity(0.3))
                        .cornerRadius(12)
                    }
                    
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
                WinView(quit: { dismiss() })
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    RollView()
        .environmentObject(GameController())
}
