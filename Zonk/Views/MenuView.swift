//
//  ContentView.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/23/23.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var matchManager: MatchManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("Zonk!")
                    .font(.system(size: 80, design: .rounded))
                    .fontWeight(.heavy)
                    .padding([.bottom, .top], 75)
                    .foregroundStyle(.white)
                    .shadow(
                        color: Color.primary,
                            radius: 3,
                            x: 2,
                            y: 2
                    )
                
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
                    matchManager.startMatchmaking()
                } label: {
                    Text("Multiplayer")
                        .modifier(BorderButtonModifier(borderColor: .black))
                        .background(
                            Capsule(style: .circular)
                                .fill(
                                    matchManager.authenticationState != .authenticated || matchManager.inMatch ? .gray : .blue
                                )
                        )
                }
                .disabled(matchManager.authenticationState != .authenticated || matchManager.inMatch ? true : false)
                
                Text(matchManager.authenticationState.rawValue)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                
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
    }
}

#Preview {
    MenuView(matchManager: MatchManager())
}
