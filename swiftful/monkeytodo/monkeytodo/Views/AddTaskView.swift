//
//  AddTaskView.swift
//  monkeytodo
//
//  Created by Matthew Fang on 6/9/25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ListViewModel.self) private var viewModel
    @State var taskTitle: String = ""
    
    // MARK: ALL ALERTS HAVE 1) A CHANGEABLE TITLE AND 2) AN ISPRESENTED BOOL
    @State var alertTitle: String = ""
    @State var alertIsPresented: Bool = false

    var body: some View {
        Form {
            TextField("Task name", text: $taskTitle)
//            Button("Save task") {
//                saveTask()
//            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    saveTask()
                } label: {
                    Image(systemName: "checkmark")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle("Add a task")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $alertIsPresented) {
            Alert(title: Text(alertTitle))
        }
    }

    // MARK: YOU CAN (SHOULD) HAVE FUNCTIONS IN YOUR VIEWS!! - if they are DIRECTLY related to the view functionality and NOT related to any model stuff, then just keep them in the View to reduce clutter in viewModel
    
    // MARK: always ask: does this function NEED to interface with the model? or is it just to help this one view?
    
    func saveTask() {
        if textIsAppropriate(text: taskTitle) {
            viewModel.addItem(title: taskTitle)
            dismiss()
        } else {
            alertTitle = "tasks must be at least 3 characters long!"
            alertIsPresented.toggle()
        }
    }

    func textIsAppropriate(text: String) -> Bool {
        if text.count < 3 {
            return false
        }
        return true
    }
}

#Preview {
    NavigationStack {
        AddTaskView()
            .environment(ListViewModel())
    }
}
