//
//  PlayerInfoView.swift
//  Zonk
//
//  Created by Artur Uvarov on 4/16/24.
//

import SwiftUI

struct PlayerInfoView: View {
    let onClose: () -> Void
    var name: String = UserDefaultsService.shared.getUsername() ?? "Default"
    var topScore: Int = UserDefaultsService.shared.getUserTopScore() ?? 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Player Info")
                .font(.title)
                .foregroundColor(.blue)
            
            Text("Name: \(name)")
                .font(.headline)
            
            Text("Top Score: \(topScore)")
                .font(.headline)
            
            Button(action: {
                onClose()
            }) {
                Text("Close")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.bottom, 40)
            }
        }
        .padding(.top, 50)
        .frame(maxWidth: 350)
        .background(Color.white.opacity(0.8))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}


#Preview {
    PlayerInfoView(onClose: {})
}
