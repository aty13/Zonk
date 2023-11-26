//
//  ZonkView.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/25/23.
//

import SwiftUI

struct ZonkView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .ignoresSafeArea()
            
            Text("Zonk!")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    ZonkView()
}
