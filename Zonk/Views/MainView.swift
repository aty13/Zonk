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
    NavigationView {
      VStack {
        Text("Welcome to Zonk!")
          .font(.title)
          .fontWeight(.bold)
          .padding([.bottom, .top], 150)

        NavigationLink(destination: RollView()) {
          Text("Single Player")
            .modifier(BeautifulButtonStyle())
        }

        Button(action: {
          withAnimation(.spring()) {
            showHowToPlay.toggle()
          }
        }) {
          Text("How to Play")
            .modifier(BeautifulButtonStyle())
        }

        Spacer()
      }
      .frame(maxWidth: .infinity)
      .navigationBarHidden(true)
      .background(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing))
      .sheet(isPresented: $showHowToPlay) {
        HowToPlayView(onClose: {
          showHowToPlay.toggle()
        })
          .transition(.move(edge: .bottom).combined(with: .opacity))
      }
    }
  }
}

struct BeautifulButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding()
      .background(
        Color.white
//        /*LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.8), .green.opacity(0.8)]), startPoint: .topLeading, endPoint: .*/bottomTrailing)
      )
      .foregroundColor(.black)
      .cornerRadius(10)
      .shadow(color: .gray.opacity(0.2), radius: 5)
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


#Preview {
    MainView()
}
