//
//  HotSeatSetupView.swift
//  Zonk
//
//  Created by Artur Uvarov on 3/1/24.
//

import SwiftUI

struct HotSeatSetupView: View {
    
    @State private var players: [Player] = [Player(
        name: UserDefaultsService.shared.getUsername() ?? "Default",
        ai: false
    )]
    @State private var newPlayerName: String = ""
    @State private var isRollScreenActive = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        List {
                            ForEach(players) { player in
                                PlayerListItem(player: player)
                            }
                            .onDelete { indexSet in
                                players.remove(atOffsets: indexSet)
                            }
                        }
                    } header: {
                        Text("Players list")
                    }
                    .navigationTitle("Players")
                    
                    if players.count <= 5 {
                        Section {
                            TextField(text: $newPlayerName) {
                                Text("Player name")
                            }
                            .padding()
                            .background(.green.opacity(0.07))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            
                            HStack {
                                Button("Add Player") {
                                    withAnimation {
                                        guard !newPlayerName.isEmpty else { return }
                                        players.append(
                                            Player(
                                                name: newPlayerName,
                                                ai: false
                                            )
                                        )
                                        newPlayerName = ""
                                    }
                                }
                                .padding()
                                .background(.blue.opacity(0.2))
                                
                            }
                            
                        } header: {
                            Text("Type player name to add")
                        }
                    }
                }
                
                NavigationLink(
                    destination: RollView()
                        .environmentObject(
                            LocalZonkController(
                                players: players
                            )
                        )
                ) {
                    HStack {
                        Image(systemName: "gamecontroller")
                        Text(players.count < 2 ? "No less than two players" : "Start Game")
                    }
                    .padding()
                    .foregroundColor(.black)
                    .background(players.count < 2
                                ? Color.red.opacity(0.7)
                                : Color.green.opacity(0.7)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .padding()
                .disabled(players.count < 2 ? true : false)
            }
            .background(.green.opacity(0.3))
            
        }
        
    }
}

#Preview {
    HotSeatSetupView()
        .environmentObject(LocalZonkController())
}

