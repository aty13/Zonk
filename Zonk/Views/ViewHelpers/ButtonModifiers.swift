//
//  ButtonModifiers.swift
//  Zonk
//
//  Created by Artur Uvarov on 4/17/24.
//

import SwiftUI

struct BorderButtonModifier: ViewModifier {
    let borderColor: Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: 100)
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
