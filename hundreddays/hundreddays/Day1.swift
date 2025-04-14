//
//  ContentView.swift
//  hundreddays
//
//  Created by Matthew Fang on 4/13/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Form {
                Text("Hello, world! How are you?")
                Text("Hello, world! How are you?")
                Text("Hello, world! How are you?")
            }
            .navigationTitle("Monkey")
        }
    }
}

#Preview {
    ContentView()
}
