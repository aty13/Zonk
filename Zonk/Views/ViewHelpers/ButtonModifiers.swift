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
            .foregroundStyle(.white)
            .font(.title3)
            .fontWeight(.bold)
            .frame(width: 150)
            .padding(.vertical, 20)
            .padding(.horizontal, 70)
    }
}
