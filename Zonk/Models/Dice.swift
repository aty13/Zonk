//
//  Dice.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/23/23.
//

import Foundation

struct Dice: Identifiable, Equatable, Hashable {
    var id: UUID
    let value: Int
    
    func getImage() -> String {
        switch value {
            case 1:
                return "one"
            case 2:
                return "two"
            case 3:
                return "three"
            case 4:
                return "four"
            case 5:
                return "five"
            case 6:
                return "six"
            default:
                fatalError("Invalid dice number")
        }
    }

    init(number: Int) {
        id = UUID()
        value = number
    }
}
