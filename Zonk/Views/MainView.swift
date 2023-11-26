//
//  ContentView.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/23/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Welcome to Zonk Game")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                Spacer()
                
                NavigationLink(destination: RollView()) {
                    Text("Single Player")
                        .modifier(BlueButtonStyle())
                }
                
                NavigationLink(destination: RollView()) {
                    Text("Hot seat")
                        .modifier(BlueButtonStyle())
                }
                
                NavigationLink(destination: RollView()) {
                    Text("Multiplayer")
                        .modifier(BlueButtonStyle())
                }
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }

    struct BlueButtonStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}

#Preview {
    MainView()
}
