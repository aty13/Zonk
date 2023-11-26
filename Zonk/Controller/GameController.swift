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
    var chosenDicesShort: [Dice]
    
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
        chosenDicesShort = []
    }
 
    
//    while !zonk {
//        roll
//        handledicetap
//        save/next move
    
    mutating func roll() {
        chosenDicesShort = []
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
        let tripletsFound = areThereAnyTriplets().found
        let containsOneOrFive = currentRoll.contains { $0.value == 1 || $0.value == 5 }
        
        return !tripletsFound && !containsOneOrFive
    }
    
    mutating func itIsZonk() {
        dicesAmount = 6
        chosenDices = []
        currentTriplets = []
        currentRoll = []
        unsavedResult = 0
        zonk = false
        canRoll = true
        canSave = false
    }
    
    mutating func handleDiceTap(_ dice: Dice) {
        
        if dice.value == 1 || dice.value == 5 || currentTriplets.contains(where: { $0.value == dice.value }) {
            chosenDices.append(dice)
            chosenDicesShort.append(dice)
            
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
 
    mutating func addPreScore(dice: Dice) {
        let scoringTable: [Int: Int] = [
            1: 100,
            5: 50,
            7: dice.value * 100,
//            8: dice.value * 100,
//            9: dice.value * 100 + dice.value * 100,
//            10: dice.value * 100 + dice.value * 100 + dice.value * 100,
    //        11 : 750,
    //        12 : 1000
        ]
        
        let sameDices = chosenDicesShort.filter { $0.value == dice.value }

        switch dice.value {
        case 1:
            if sameDices.count < 3 {
                unsavedResult += scoringTable[1]!
            } else {
                updateResultForSameDices(sameDicesAmount: sameDices.count, values: [3: 800, 4: 1000, 5: 2000, 6: 3000])
            }
            
        case 5:
            if sameDices.count < 3 {
                unsavedResult += scoringTable[5]!
            } else {
                updateResultForSameDices(sameDicesAmount: sameDices.count, values: [3: 400, 4: 500, 5: 1000, 6: 1500])
            }
            
        default:
            if sameDices.count >= 3 {
                updateResultForSameDices(
                    sameDicesAmount: sameDices.count,
                    values: [
                        3: scoringTable[7]!,
                        4: scoringTable[7]!,
                        5: scoringTable[7]!,
                        6: scoringTable[7]!
                    ]
                )
            }
        }
        
        if unsavedResult >= 300 {
            canSave = true
        }
    }

    private mutating func updateResultForSameDices(sameDicesAmount: Int, values: [Int: Int]) {
        switch sameDicesAmount {
        case 3, 4, 5, 6:
            unsavedResult += values[sameDicesAmount]!
        default:
            return
        }
    }
    
    mutating func saveScore() {
        score += unsavedResult
        unsavedResult = 0
        dicesAmount = 6
        currentRoll = []
        currentTriplets = []
        chosenDices = []
        canSave = false
    }
    
    mutating func restart() {
        score = 0
        unsavedResult = 0
        dicesAmount = 6
        currentRoll = []
        currentTriplets = []
        chosenDices = []
        canSave = false
        canRoll = true
        zonk = false
    }
}
