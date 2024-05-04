/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 The view that displays the game play interface.
 */

import SwiftUI

struct GameView: View {
//    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var game: TurnBasedGame
    @State private var showMessages: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                MultiplayerScoreView(game: game)
                    .padding(.top, 20)
                Button("Quit") {
                    game.quitGame()
                }
                
                HStack {
                    HStack(alignment: .top) {
                        Form {
                            
                            Section("Score") {
                                HStack {
                                    HStack {
                                        game.myAvatar
                                            .resizable()
                                            .frame(width: 35.0, height: 35.0)
                                            .clipShape(Circle())
                                        
                                        Text(game.myName)
                                            .lineLimit(2)
                                    }
                                    Spacer()
                                    
                                    Text("\(game.myItems)")
                                        .lineLimit(2)
                                }
                                .listRowBackground(Rectangle().fill(game.myTurn ? .blue.opacity(0.25) : .white))
                                
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
                                    
                                    Text("\(game.opponentItems)")
                                        .lineLimit(2)
                                }
                                .listRowBackground(Rectangle().fill(game.myTurn ? .white : .blue.opacity(0.25)))
                                
                                HStack {
                                    Text("Unsaved result")
                                        .lineLimit(2)
                                    Spacer()
                                    
                                    Text("\(game.unsavedResult)")
                                }
                            }
                        }
                        .frame(height: 180)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                
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
                .padding([.top], 150)
                .frame(maxHeight: 300)
                
                Spacer()
                
                HStack {
                    if game.canSave {
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
                    
                    if game.canRoll {
                        Button {
                            game.roll()
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
            
            //            if gameController.zonk {
            //                ZonkView()
            //                    .onAppear {
            //
            //                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //                            gameController.itIsZonk()
            //                        }
            //                    }
            //            }
            //
            //            if gameController.win {
            //                WinView(quit: { dismiss() })
            //            }
        }
        //        .navigationBarHidden(true)
        
        // Display the text message view if it's enabled.
        .sheet(isPresented: $showMessages) {
            ChatView(game: game)
        }
        .alert("Game Over", isPresented: $game.youWon, actions: {
            Button("OK", role: .cancel) {
                game.resetGame()
            }
        }, message: {
            Text("You win.")
        })
        .alert("Game Over", isPresented: $game.youLost, actions: {
            Button("OK", role: .cancel) {
                game.resetGame()
            }
        }, message: {
            Text("You lose.")
        })
    }
}

struct GameViewPreviews: PreviewProvider {
    static var previews: some View {
        GameView(game: TurnBasedGame())
    }
}

struct MessageButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isPressed ? "bubble.left.fill" : "bubble.left")
                .imageScale(.medium)
            Text("Text Chat")
        }
        .foregroundColor(Color.blue)
    }
}

//
//Section("Game Controls") {
//    Button("Take Turn") {
//        Task {
//            await game.takeTurn()
//        }
//    }
//    .disabled(!game.myTurn)
//
//    Button("Back") {
//        game.quitGame()
//    }
//    Button("Forfeit") {
//        Task {
//            await game.forfeitMatch()
//        }
//    }
//}
//Section("Exchanges") {
//    // Send a request to exchange an item.
//    Button("Exchange Item") {
//        Task {
//            await game.exchangeItem()
//        }
//    }
//    .disabled(game.opponent == nil)
//}
//Section("Communications") {
//    HStack {
//        // Send text messages as exchange items.
//        Button("Message") {
//            withAnimation(.easeInOut(duration: 1)) {
//                showMessages = true
//            }
//        }
//        .buttonStyle(MessageButtonStyle())
//        .onTapGesture {
//            presentationMode.wrappedValue.dismiss()
//        }
//    }
//    // Send a reminder to take their turn.
//    Button("Send Reminder") {
//        Task {
//            await game.sendReminder()
//        }
//    }
//    .disabled(game.myTurn)
//}
