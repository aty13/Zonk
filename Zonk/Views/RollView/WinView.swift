//
//  WinView.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/26/23.
//

import SwiftUI

struct WinView: View {
    @EnvironmentObject var gameController: GameController
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("You won!")
                    .font(.largeTitle)
                .fontWeight(.bold)
                
                Button {
//                    gameController.restart()
                } label: {
                    Text("Try again")
                }
                .padding([.top], 300)
                
            }
            
            
        }
    }
}

//#Preview {
//    WinView()
//        .environment(<#T##object: Observable?##Observable?#>)
//}
