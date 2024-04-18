//
//  ZonkView.swift
//  Zonk
//
//  Created by Artur Uvarov on 11/25/23.
//

import SwiftUI

struct ZonkView: View {
    @State var isShowing = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .ignoresSafeArea()
            
            
            Image("zonk")
                .resizable()
                .frame(width: 350, height: 350)
                .cornerRadius(25)
                .opacity(isShowing ? 1.0 : 0.0)

        }
        .onAppear {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.isShowing = true
                    }
                }
    }
}

#Preview {
    ZonkView()
}
