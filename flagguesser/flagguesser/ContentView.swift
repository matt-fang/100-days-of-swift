//
//  ContentView.swift
//  flagguesser
//
//  Created by Matthew Fang on 5/20/25.
//

import SwiftUI

struct ContentView: View {
    let countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"]

    @State private var correctAnswer = Int.random(in: 0 ... 2)
    @State private var selectedCountries: [String] = []

    @State private var score = 0
    
    @State private var showAlert = false

    func choose(_ number: Int, from list: [String]) -> [String] {
        var new_list = Set<String>()

        while new_list.count < number {
            new_list.insert(list[Int.random(in: 0 ..< list.count)])
        }

        print([String](new_list))
        return [String](new_list)
    }

    var body: some View {
        ZStack {
            Color(Color(white: 0.95))
                .ignoresSafeArea()

            VStack {
                HStack {
                    Text("Score: \(score)")
                    Spacer()
                }
                Spacer()
                
                if selectedCountries.count == 3 {
                    Text("Tap the flag of:")
                    Text(selectedCountries[correctAnswer])
                        .font(.title)
                    ForEach(0 ..< selectedCountries.count, id: \.self) { index in
                        Button {
                            print(selectedCountries[index])

                            if index == correctAnswer {
                                print("correct!")
                                score += 1
                            } else {
                                print("wrong :(")
                                showAlert = true
                            }

                            correctAnswer = Int.random(in: 0 ... 2)
                            selectedCountries = choose(3, from: countries)

                        } label: {
                            Image(selectedCountries[index])
                                .padding()
                        }
                        .alert("Score \(score)", isPresented: $showAlert) {
                            Button("Play Again!") { score = 0 }
                        }
                    }
                } else {
                    ProgressView()
                }
                Spacer()
            }
            .padding()
            .onAppear {
                selectedCountries = choose(3, from: countries)
                print(selectedCountries)
            }

        }
    }
}

#Preview {
    ContentView()
}
