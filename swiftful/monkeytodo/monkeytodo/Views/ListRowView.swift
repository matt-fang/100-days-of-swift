//
//  ListRowView.swift
//  monkeytodo
//
//  Created by Matthew Fang on 6/9/25.
//

import SwiftUI

struct ListRowView: View {
    let task: TodoItem
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
            Text(task.title)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ListRowView(task: TodoItem(title: "1st", isCompleted: false))
    ListRowView(task: TodoItem(title: "2nd", isCompleted: true))
}
