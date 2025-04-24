import SwiftUI

struct MoneySharerView: View {
    @State private var preTipAmount = 50.0
    @State private var numberOfPeople = 5
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var amountPerPerson: Double {
        let postTipAmount = preTipAmount * (1 + Double(tipPercentage) / 100)
        return postTipAmount / Double(numberOfPeople)
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Total Amount", value: $preTipAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                
                Picker("Number of People", selection: $numberOfPeople) {
                    ForEach(2 ..< 13, id: \.self) {
                        Text("\($0) people")
                    }
                }
                
                Section("TIP PERCENTAGE") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { percent in
                            Text("\(percent)%")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    if tipPercentage == 0 {
                        Text("so stingy!! >:(")
                    }
                }
                
                Section {
                    Text(amountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("Money Sharer")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    MoneySharerView()
}
