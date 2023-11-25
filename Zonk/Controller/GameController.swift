//
//  ZonkController.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/23/23.
//

import Foundation

struct GameController {
    var score: Int
    var unsavedResult: Int
    var dicesAmount: Int
    var canRoll: Bool
    var canSave: Bool
    var zonk: Bool
    var currentRoll: [Dice]
    var currentTriplets: [Dice]
    var chosenDices: [Dice]
    
    init() {
        score = 0
        unsavedResult = 0
        dicesAmount = 6
        canRoll = true
        canSave = false
        zonk = false
        currentRoll = []
        currentTriplets = []
        chosenDices = []
    }
 
    
//    while !zonk {

//        roll
//        handledicetap
//        save/next move
    
    mutating func roll() {
        var result: [Dice] = []
        canRoll = false
        
        if dicesAmount == 0 {
            dicesAmount = 6
            chosenDices = []
            currentTriplets = []
        }
        
        for _ in 1...dicesAmount {
            let randomInt = Int.random(in: 1...6)
            let currentDice = Dice(number: randomInt)
            result.append(currentDice)
        }
        
        currentRoll = result
        
        let tripletsTuple = areThereAnyTriplets();
        
        if let triplets = tripletsTuple.values {
            currentTriplets = currentRoll.filter { triplets.contains($0.value) }
        }
        
        if checkForZonk() {
            zonk = true
        }
    }
    
    func checkForZonk() -> Bool {
        return !canRoll && !canSave
    }
    
    mutating func handleDiceTap(_ dice: Dice) {
        
        if dice.value == 1 || dice.value == 5 || (areThereAnyTriplets().found && currentTriplets.contains(where: { $0.value == dice.value })) {
            chosenDices.append(dice)
            
            
            if let indexToRemove = currentRoll.firstIndex(of: dice) {
                currentRoll.remove(at: indexToRemove)
            }
            
            dicesAmount -= 1
            
            addPreScore(dice: dice)
            
            canRoll = true
        } else {
            return
        }
    }
    
    func areThereAnyTriplets() -> (found: Bool, values: [Int]?) {
        var diceCount: [Int: Int] = [:]

        for dice in currentRoll {
            if let count = diceCount[dice.value] {
                diceCount[dice.value] = count + 1
            } else {
                diceCount[dice.value] = 1
            }
        }
        
        let triplets = diceCount.filter { $0.value >= 3 }.map { $0.key }
        let hasTriplets = !triplets.isEmpty
        
        return (found: hasTriplets, values: hasTriplets ? triplets : nil)
    }
    
    func saveScore() {
        
    }
 
    mutating func addPreScore(dice: Dice) {
        let scoringTable = [
            1: 100,
            5: 50,
            7: dice.value * 10,
            8: dice.value * 10 + dice.value * 10,
            9: dice.value * 10 + dice.value * 10 + dice.value * 10,
            10: dice.value * 10 + dice.value * 10 + dice.value * 10 + dice.value * 10,
            11 : 750,
            12 : 1000
        ]
        
        switch dice.value {
        case 1:
            unsavedResult += scoringTable[1]!
        case 5:
            unsavedResult += scoringTable[5]!
        default:
            return
        }
    }
}
