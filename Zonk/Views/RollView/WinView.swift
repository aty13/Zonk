//
//  WinView.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/26/23.
//

import SwiftUI

struct WinView: View {
    @EnvironmentObject var gameController: LocalZonkController
    let quit: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .ignoresSafeArea()
            
            VStack {
                Text("You won!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 50)
                
                Button(action: {
                    gameController.restart()
                }) {
                    Text("Try again")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                }
                
                Button(action: {
                    gameController.restart()
                    quit()
                }) {
                    Text("Quit")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 50)
                }
            }

        }
    }
}

#Preview {
    WinView(quit: {})
        .environmentObject(LocalZonkController())
}
