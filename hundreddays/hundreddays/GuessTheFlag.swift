//
//  GuessTheFlag.swift
//  hundreddays
//
//  Created by Matthew Fang on 5/7/25.
//

import SwiftUI

struct GuessTheFlag: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.blue
                Color.mint
            }
            VStack {
                Text("Monkey")
                    .foregroundStyle(.secondary)
                    .padding(50)
                    .background(.ultraThinMaterial)
                Button("Delete!", role: .destructive) {
                    print("deleted")
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    GuessTheFlag()
}
