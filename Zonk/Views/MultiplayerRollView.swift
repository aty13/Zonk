//
//  MultiplayerRollView.swift
//  Zonk
//
//  Created by Artur Uvarov on 5/5/24.
//

import SwiftUI

struct MultiplayerRollView: View {
    @ObservedObject var matchManager: MatchManager
    @State var message = ""
    
    func sendMessage() {
        guard message != "" else { return }
        
        matchManager.sendString("message:\(message)")
        
        message = ""
    }
    
    var body: some View {
        VStack {
            Text("Game view")
                .font(.largeTitle)
                .padding(.bottom, 50)
            
            testText
            
            Spacer()
            
            promtPart
        }
        .background(.gray)
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
        
        
    }
    
    var testText: some View {
        
        VStack {
            if matchManager.messages.isEmpty {
                Text("Nothing yet")
            }
            else {
                ForEach(matchManager.messages) { message in
                    Text(message.text)
                }
            }
        }
    }
    
    var promtPart: some View {
        HStack {
            TextField("Type your message", text: $message)
                .padding()
                .background(
                    Capsule(style: .circular)
                        .fill(.white)
                )
            Button {
                sendMessage()
            } label: {
                Image(systemName: "chevron.right.circle.fill")
                    .font(.system(size: 50))
            }
        }
        .padding()
    }
}

#Preview {
    MultiplayerRollView(matchManager: MatchManager())
}
