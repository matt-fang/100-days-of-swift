//
//  SwiftUIView.swift
//  monkeyescape
//
//  Created by Matthew Fang on 6/11/25.
//

import SwiftUI

struct InitEnum: View {
    
    let backgroundColor: Color
    
    var body: some View {
        ZStack {
            Color.secondary.opacity(0.2)
            GlassEffectContainer {
                VStack {
                    Text("5")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("apples")
                        .font(.subheadline)
                }
                .foregroundStyle(.white)
                .frame(width: 100, height: 100)
            }
            .glassEffect(.regular.tint(backgroundColor).interactive())
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    InitEnum(backgroundColor: .blue)
}
