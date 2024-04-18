//
//  ContentView.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/23/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var gameController: GameController
    @State private var showHowToPlay = false
    @State private var showPlayerInfo = false
    @State private var showNameAlert = false
    @State private var newPlayerName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Zonk!")
                    .font(.system(size: 70, design: .rounded))
                    .fontWeight(.heavy)
                    .padding([.bottom, .top], 75)
                    .foregroundStyle(.white)
                    .shadow(
                        color: Color.primary,
                            radius: 3,
                            x: 2,
                            y: 2
                    )
                
                NavigationLink(destination: RollView()) {
                    Text("Single Play")
                        .modifier(BorderButtonModifier(borderColor: .black))
                }
                
                NavigationLink(destination: HotSeatSetupView()) {
                    Text("Hot seat")
                        .modifier(BorderButtonModifier(borderColor: .black))
                }
                Button(action: {
                    withAnimation(.default ) {
                        showPlayerInfo.toggle()
                    }
                }) {
                    Text("Player info")
                        .modifier(BorderButtonModifier(borderColor: .black))
                }
                .padding([.top], 20)
                
                Button(action: {
                    withAnimation(.default ) {
                        showHowToPlay.toggle()
                    }
                }) {
                    Text("How to Play")
                        .modifier(BorderButtonModifier(borderColor: .black))
                }
                .padding([.top], 50)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .navigationBarHidden(true)
            .background(
                Image("background-main")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            )
            
            .sheet(isPresented: $showHowToPlay) {
                HowToPlayView(onClose: { showHowToPlay.toggle() })
                    .presentationBackground(.ultraThinMaterial)
            }
            .sheet(isPresented: $showPlayerInfo) {
                PlayerInfoView(onClose: { showPlayerInfo.toggle() })
                    .presentationBackground(.ultraThinMaterial)
                    
            }
            
        }
        .onAppear {
            if UserDefaultsService.shared.getUsername() == nil {
                showNameAlert.toggle()
            }
        }
        .alert("Please provide your name", isPresented: $showNameAlert) {
            TextField("Player name", text: $newPlayerName)
                .padding()
                .background(Color.green.opacity(0.07))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            Button(action: {
                if newPlayerName.isEmpty {
                    UserDefaultsService.shared.saveUsername("Default")
                } else {
                    UserDefaultsService.shared.saveUsername(newPlayerName)
                }
            }) {
                Text("Save")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
        }

    }
    
    func saveName() {
        if !newPlayerName.isEmpty {
            
        }
    }
}

#Preview {
    MainView()
        .environmentObject(GameController())
}
