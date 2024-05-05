//
//  MainView.swift
//  Zonk
//
//  Created by Artur Uvarov on 5/4/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var matchManager = MatchManager()
    
    var body: some View {
        ZStack {
            if matchManager.isGameOver {
                Text("Game Over!")
            }
            else if matchManager.inMatch {
                RollView()
            }
            else {
                MenuView(matchManager: matchManager)
            }
        }
        .onAppear {
            matchManager.authenticateUser()
        }
    }
}

#Preview {
    MainView()
}
