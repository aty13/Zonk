//
//  UserDefaultsService.swift
//  Zonk
//
//  Created by Artur Uvarov on 4/15/24.
//

import Foundation


class UserDefaultsService {
    static let shared = UserDefaultsService()
    private let userDefaults = UserDefaults.standard
    
    private let usernameKey = "Username"
    private let diceThrowRecordKey = "RunRecord"
    
    func saveUsername(_ username: String) {
        userDefaults.set(username, forKey: usernameKey)        
    }
    
    func saveUserTopScore(_ topScore: Int) {
        let currentTopScore = userDefaults.integer(forKey: diceThrowRecordKey)
        
        if currentTopScore < topScore {
            userDefaults.set(topScore, forKey: diceThrowRecordKey)
        }
    }
    
    func getUsername() -> String? {
        guard let username = userDefaults.string(forKey: usernameKey) else {
            return nil
        }
        
        return username
    }
    
    func getUserTopScore() -> Int? {
        let bestRunScore = userDefaults.integer(forKey: diceThrowRecordKey)
        return bestRunScore
    }
    
    func resetUserTopScore() {
        userDefaults.set(0, forKey: diceThrowRecordKey)
    }
}
