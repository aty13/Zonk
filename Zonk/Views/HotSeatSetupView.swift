//
//  HotSeatSetupView.swift
//  Zonk
//
//  Created by Artur Uvarov on 3/1/24.
//

import SwiftUI

struct HotSeatSetupView: View {
    @EnvironmentObject var gameController: GameController
    
    @State private var newPlayerName: String = ""
    @State private var isRollScreenActive = false
    @State private var updatedWinScore = 10000
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        List {
                            ForEach(gameController.players) { player in
                                Text(player.name)
                            }
                            .onDelete { indexSet in
                                gameController.players.remove(atOffsets: indexSet)
                            }
                        }
                    } header: {
                        Text("Players list")
                    }
                    .navigationTitle("Players")
                    
                    Section {
                        TextField(text: $newPlayerName) {
                            Text("Player name")
                            
                        }
                        .padding()
                        .background(.green.opacity(0.07))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        
                        Button("Add Player") {
                            withAnimation {
                                guard !newPlayerName.isEmpty else { return }
                                gameController.players.append(Player(name: newPlayerName))
                                newPlayerName = ""
                                
                            }
                        }
                        .padding()
                        .background(.blue.opacity(0.2))
                        .disabled(gameController.players.count >= 6)
                    } header: {
                        Text("Type player name to add")
                    }
                    
                    Section {
                        TextField("Winning Score", value: $updatedWinScore, format: .number)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .foregroundColor(.black)
                            .font(.body)
                        
                        Button("Change score target") {
                            gameController.changeWinscore(updatedWinScore)
                        }
                        .padding()
                        .background(.blue.opacity(0.2))
                    } header: {
                        Text("Target score to win, currently \(gameController.winScore)")
                    }
                }
                
                NavigationLink(destination: RollView()) {
                    HStack {
                        Image(systemName: "gamecontroller")
                        Text(gameController.players.count < 2 ? "No less than two players" : "Start Game")
                    }
                    .padding()
                    .foregroundColor(.black)
                    .background(gameController.players.count < 2 
                                ? Color.red.opacity(0.7)
                                : Color.green.opacity(0.7)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .padding()
                .disabled(gameController.players.count < 2 ? true : false)
            }
            .background(.green.opacity(0.3))
            
        }
        
    }
}

struct RedButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
    }
}

struct BlueButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding()
            .background(Color.green)
            .cornerRadius(10)
    }
}



#Preview {
    HotSeatSetupView()
        .environmentObject(GameController())
}
