//
//  ContentView.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/23/23.
//

import SwiftUI

struct MainView: View {
    
    @State private var showHowToPlay = false
    
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
                    Text("Single Player")
                        .modifier(BorderButtonModifier(borderColor: .black))
                }
                
                NavigationLink(destination: HotSeatSetupView()) {
                    Text("Hot seat")
                        .modifier(BorderButtonModifier(borderColor: .black))
                }
                
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
                HowToPlayView(onClose: {
                    showHowToPlay.toggle()
                })
            }
        }
        
    }
}

struct BorderButtonModifier: ViewModifier {
    let borderColor: Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            .padding()
            .background(Color.white)
            .foregroundColor(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 2)
            )
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.2), radius: 5)
    }
}

#Preview {
    MainView()
        .environmentObject(GameController())
}
