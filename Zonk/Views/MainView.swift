//
//  MainView.swift
//  Zonk
//
//  Created by Artur Uvarov on 5/4/24.
//

import SwiftUI
import GameKit

struct MainView: View {
    @StateObject private var game = MatchManager()
    @State private var showFriends = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("Zonk!")
                    .font(.system(size: 80, design: .rounded))
                    .fontWeight(.heavy)
                    .padding([.bottom, .top], 75)
                    .foregroundStyle(.white)
                    .shadow(color: Color.primary, radius: 3, x: 2, y: 2)
                
                NavigationLink(
                    destination: RollView().environmentObject(GameController())
                ) {
                    
                    Text("Single Play")
                        .modifier(BorderButtonModifier(borderColor: .black))
                        .background(Capsule(style: .circular))
                }
                
                NavigationLink(
                    destination: HotSeatSetupView().environmentObject(GameController())
                ) {
                    Text("Hot seat")
                        .modifier(BorderButtonModifier(borderColor: .black))
                        .background(Capsule(style: .circular))
                }
                
                Button {
                    game.choosePlayer()
                } label: {
                    Text("Multiplayer")
                        .modifier(BorderButtonModifier(borderColor: .black))
                        .background(
                            Capsule(style: .circular)
                                .fill(game.matchAvailable ? .blue : .gray)
                        )
                }
                .disabled(!game.matchAvailable)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .navigationBarHidden(true)
            .background(
                Image("background-main")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            )
        }
        // Authenticate the local player when the game first launches.
        .onAppear {
            if !game.playingGame {
                game.authenticatePlayer()
            }
        }
        
        // Display the game interface if a match is ongoing.
        .fullScreenCover(isPresented: $game.playingGame) {
            MultiplayerRollView(game: game)
        }
    }
}

struct BorderButtonModifier: ViewModifier {
    let borderColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .font(.title3)
            .fontWeight(.bold)
            .frame(width: 150)
            .padding(.vertical, 20)
            .padding(.horizontal, 70)
    }
}


#Preview {
    MainView()
}
