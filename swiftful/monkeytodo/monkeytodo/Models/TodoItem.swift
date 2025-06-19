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
    
    // MARK: ALSO NOTE THAT YOU CAN'T MUTATE STRUCTS AT ALL! HENCE THE RETURNING A NEW COPY
    // MARK: if you make this a mutating func { isCompleted.toggle() }, it's REALLY just returning a copy of TodoItem but with isCompleted changed — just like you're doing right now!
    func updateItem() -> TodoItem {
        return TodoItem(id: id, title: title, isCompleted: !isCompleted)
    }
}
