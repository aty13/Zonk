//
//  PlayerListItem.swift
//  Zonk
//
//  Created by Artur Uvarov on 4/17/24.
//

import SwiftUI

struct PlayerListItem: View {
    var player: Player
    
    var body: some View {
        HStack {
            Text(player.name)
                
            if player.ai {
                Image(systemName: "gearshape")
                    
            }
        }
    }
}


#Preview {
    PlayerListItem(player: Player(name: getRandomAIName(), ai: true))
}
