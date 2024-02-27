//
//  DiceView.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/23/23.
//

import SwiftUI

struct DiceView: View {
    var dice: Dice
    var size: CGSize
    
    var body: some View {
        Image(dice.getImage())
            .resizable()
            .frame(width: size.width, height: size.height)
            .cornerRadius(12)
    }
}

#Preview {
    DiceView(dice: Dice(number: 1), size: CGSize(width: 100, height: 100))
}
