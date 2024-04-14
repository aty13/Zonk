//
//  TopButton.swift
//  Zonk
//
//  Created by Artur Uvarov on 4/14/24.
//

import SwiftUI

struct TopButton: View {
    @Binding var isPresentingConfirm: Bool
    let systemImageName: String
    let confirmationTitleText: String
    let confirmationButtonText: String
    var buttonAction: () -> Void
    
    var body: some View {
        Button(action: {
            isPresentingConfirm.toggle()
        }) {
            Image(systemName: systemImageName)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .font(.system(size: 25))
        }
        .confirmationDialog("Sure?", isPresented: $isPresentingConfirm) {
            VStack {
                Text(confirmationTitleText)
                Button(confirmationButtonText, role: .destructive) {
                       buttonAction()
                }
            }
            
            
        }
    }
}

//#Preview {
//    RollView()
//}

//"gobackward"

//"You want to restart?"
