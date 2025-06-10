//
//  TodoItem.swift
//  monkeytodo
//
//  Created by Matthew Fang on 6/9/25.
//

import Foundation

struct TodoItem: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    // MARK: in immutable structs, INCLUDE THE UPDATE FUNCTION IN THE MODEL (to reduce clutter in viewmodel)
    func updateItem() -> TodoItem {
        return TodoItem(id: id, title: title, isCompleted: !isCompleted)
    }
}
