//
//  Day6.swift
//  hundreddays
//
//  Created by Matthew Fang on 4/19/25.
//

import SwiftUI

struct Day6: View {
    let students = ["Monkey", "Matthew", "Bear"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Picker("Select your student", selection: $selectedStudent) {
                        ForEach(students, id: \.self) {
                            Text($0)
                        }
                    }
                    Section {
                        Text("Current student: \(selectedStudent)")
                    }
                }
            }.navigationTitle("StudentSelect")
        }
    }
}

#Preview {
    Day6()
}
