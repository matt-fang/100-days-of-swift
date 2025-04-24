//
//  ContentView.swift
//  hundreddays
//
//  Created by Matthew Fang on 4/13/25.
//

import SwiftUI

struct Day4: View {
    @State private var tapCount = 0
    @State private var name = ""

    var body: some View {
        Form {
            Button("Tap Count: \(tapCount)") {
                tapCount += 1
            }
            Section {
                TextField("Enter your name: ", text: $name)
                Text("Name: \(name)")
            }
        }
    }
}

#Preview {
    Day4()
}
