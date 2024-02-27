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
                .font(.title2)
                .fontWeight(.bold)
            
            Text("""
               * The game is played with six dice. Players roll the dice, and if there's a 1 on the table, they can choose it to earn 100 points. Similarly, if there's a 5, they can pick it for 50 points. After each pick, players can roll again.

               Players can choose:

                 * Single 1 or 5
                 * Three and more of a kind (e.g., three 2s for 200 points, every another plus same as previous three)

               The minimum score to save is 300 points. The game continues until a player reaches 10,000 points.
            """)
            .multilineTextAlignment(.leading)
            
            Button(action: {
                onClose()
            }) {
                Text("Close")
                    .modifier(BlueButtonStyle())
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.ignoresSafeArea())
        .cornerRadius(10)
    }
}

#Preview {
    HowToPlayView {
        return
    }
}

