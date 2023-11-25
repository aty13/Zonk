//
//  RollView.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/23/23.
//

import SwiftUI

struct RollView: View {
    @State var gameController = GameController()
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Score: \(gameController.score)/10000")
                        .font(.title)
                    Text("Current run: \(gameController.unsavedResult)")
                        .font(.title2)
                }
                Spacer()
            }
                        
            ZStack {
                Rectangle()
                    .fill(.green)
                    .frame(width: 300, height: 50)
                    .cornerRadius(12)
                
                HStack {
                    ForEach(gameController.chosenDices) { dice in
                        DiceView(dice: dice, size: CGSize(width: 30, height: 30))
                            .border(.black)
                    }
                }
            }
            
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(gameController.currentRoll) { dice in
                    DiceView(dice: dice, size: CGSize(width: 100, height: 100))
                        .onTapGesture {
                            gameController.handleDiceTap(dice)
                        }
                }
            }
            .padding([.top], 150)
            
            
            Spacer()
            
            if gameController.canRoll {
                Button {
                    gameController.roll()
                } label: {
                    Text("Roll")
                        .frame(width: 300, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.headline)
                }
            }
        }
        .padding()
    }
}

#Preview {
    RollView()
}
