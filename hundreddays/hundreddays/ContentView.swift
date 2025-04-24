//
//  ContentView.swift
//  hundreddays
//
//  Created by Matthew Fang on 4/19/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20

    let tipPercentages = [10, 15, 20, 25, 0]

    var body: some View {
        Form {
            Section {
                TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                
                Picker("Number of People", selection: $numberOfPeople) {
                    ForEach(2...12, id: \.self) {
                        Text("\($0) people")
                    }
                }
            }
            
            Section {
                Text(checkAmount/Double(numberOfPeople), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            }
        }
    }
}

#Preview {
    ContentView()
}
