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
                    Text("Start Game")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                        
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    MainView()
}
