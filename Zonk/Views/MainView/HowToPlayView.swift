//
//  HowToPlay.swift
//  Zonk
//
//  Created by Artur Uvarov on 2/25/24.
//

import SwiftUI

struct HowToPlayView: View {
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Game Rules")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Text("""
                The game is played with six dice. Players roll the dice, and if there's a 1 on the table, they can choose it to earn 100 points. Similarly, if there's a 5, they can pick it for 50 points. After each pick, players can roll again.

                Players can choose:

                • Single 1 or 5
                • Three or more of a kind (e.g., three 2s for 200 points, every additional die of the same value is worth the same as the first three)

                The minimum score to save is 300 points. The game continues until a player reaches 10,000 points.
                """)
                .multilineTextAlignment(.leading)
                .font(.body)
                .foregroundColor(.gray)
            
            Button(action: {
                onClose()
            }) {
                Text("Close")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .frame(maxWidth: 350)
        .background(Color.white.opacity(0.9))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }

}

#Preview {
    HowToPlayView {
        return
    }
}

