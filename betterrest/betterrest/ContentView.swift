//
//  ContentView.swift
//  betterrest
//
//  Created by Matthew Fang on 5/20/25.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var cupsOfCoffee = 0
    @State private var sleepGoal = 8

//    @State private var wakeUpTime: Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!

    // MARK: if you wanna init something w/ multiple lies, executre a CLOSURE! var = { ... return value}()

    // MARK: what are computed properties good for?? no idea

    @State private var wakeUpTime: Date = {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
        // this returns december 31, 1 at 8:00 AM lol (makes sense -> day 1 is Jan 1 so day 0 is Dec 31) - a-ok for our purposes
        // MARK: but is it possible to "add" Date.now to 8:00 AM to get may 21st, 8:00 am?
    }()
    
    @State private var alertIsShown = false
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            Form {
//                Stepper("Cups of coffee: \(cupsOfCoffee)", value: $cupsOfCoffee, in: 0...5)
                Picker("Cups of coffee:", selection: $cupsOfCoffee) {
                    ForEach(0...5, id: \.self) {
                        if $0 == 1 {
                            Text("\($0) cup")
                        } else {
                            Text("\($0) cups")
                        }
                    }
                }
                Picker("Ideal amount of sleep: ", selection: $sleepGoal) {
                    ForEach(6...10, id: \.self) {
                        Text("\($0) hours")
                    }
                }
                DatePicker("Wake up time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                Section {
                    Button("Calculate!") {
                        calculateBedtime()
                    }
                    .alert(alertTitle, isPresented: $alertIsShown) {
                        Button("ok") {}
                    } message: {
                        Text(alertMessage)
                    }
                }
            }
            .navigationTitle("monkey sleep")
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hour = (components.hour ?? 0) * 60
            let minute = (components.minute ?? 0) * 360
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: Double(sleepGoal), coffee: Double(cupsOfCoffee))
            
            let bedtime = wakeUpTime - prediction.actualSleep
            
            alertTitle = "you should go to sleep at:"
            alertMessage = bedtime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "error!"
            alertMessage = "there was a problem calculating your sleep time :( you should just go to sleep right now"
        }
        alertIsShown = true
    }
}

#Preview {
    ContentView()
}
