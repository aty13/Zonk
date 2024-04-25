//
//  PlayerInfoView.swift
//  Zonk
//
//  Created by Artur Uvarov on 4/16/24.
//

import SwiftUI

struct PlayerInfoView: View {
    let onClose: () -> Void
    @State private var isEditingName = false
    @State private var newName: String = UserDefaultsService.shared.getUsername() ?? "Default"
    var topScore: Int = UserDefaultsService.shared.getUserTopScore() ?? 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Player Info")
                .font(.title)
                .foregroundColor(.blue)
            
            if isEditingName {
                TextField("Enter Name", text: $newName)
                    .font(.headline)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text("Name: \(newName)")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
            }
            
            Text("Top Score in one run: \(topScore)")
                .font(.system(size: 25))
            
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            isEditingName.toggle()
                        }
                    }) {
                        Text(isEditingName ? "Cancel" : "Change Name")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    if isEditingName {
                        Button(action: {
                            UserDefaultsService.shared.saveUsername(newName)
                        }) {
                            Text("Save")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    
                    
                }
                
                
                Button(action: {
                    UserDefaultsService.shared.resetUserTopScore()
                }) {
                    Text("Reset Score")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.bottom, 30)
                }
            }
            
            Button(action: {
                onClose()
            }) {
                Text("Close")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.bottom, 30)
            }
        }
        .padding(.top, 50)
        .padding(.horizontal, 20)
        .frame(maxWidth: 350)
        .background(Color.white.opacity(0.8))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}



#Preview {
    PlayerInfoView(onClose: {})
}
