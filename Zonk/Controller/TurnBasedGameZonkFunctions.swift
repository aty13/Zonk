//
//  TurnBasedGameZonkFunctions.swift
//  Zonk
//
//  Created by Artur Uvarov on 5/2/24.
//

import Foundation

extension TurnBasedGame {
    func roll() {
//        chosenDicesShort = []
        var result: [Dice] = []
        canRoll = false
        
//        if dicesAmount == 0 {
//            dicesAmount = 6
//            chosenDices = []
//            currentTriplets = []
//        }
        
        for _ in 1...6 {
            let randomInt = Int.random(in: 1...6)
            let currentDice = Dice(number: randomInt)
            result.append(currentDice)
        }
        
        currentRoll = result
        
//        let triplets = areThereAnyTriplets();
        
//        if let triplets {
//            currentTriplets = currentRoll.filter { triplets.contains($0.value) }
//        }
//        
//        if checkForZonk() {
//            zonk = true
//            players[currentPlayerIndex].zonks += 1
//            if players[currentPlayerIndex].zonks == 3 {
//                players[currentPlayerIndex].score -= 1000
//                players[currentPlayerIndex].zonks = 0
//            }
//            nextPlayer()
//        }
        
        Task {
            await takeTurn()
        }
    }
}
