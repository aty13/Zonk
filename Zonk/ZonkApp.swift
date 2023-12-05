//
//  ZonkApp.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/23/23.
//

import SwiftUI

@main
struct ZonkApp: App {
    let gameController = GameController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(gameController)
        }
    }
}
