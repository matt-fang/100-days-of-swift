//
//  ListViewModel.swift
//  monkeytodo
//
//  Created by Matthew Fang on 6/9/25.
//

import Foundation
import Observation

@Observable class ListViewModel {
    var items: [TodoItem] = [] {
        didSet {
            saveItems()
        }
    }

    let itemsKey = "items_key"
    
    // MARK: always call your fetchData function IN THE VIEWMODEL INIT!

    init() {
        getItems()
    }
    
    // MARK: in real apps, you almost always have a getItems() function

    // MARK: it's also convenient to define getItems so you can call it in other places!

    func getItems() {
//        let newItems = [TodoItem(title: "first!", isCompleted: false),
//                        TodoItem(title: "second!", isCompleted: false),
//                        TodoItem(title: "third!", isCompleted: true)]
//        items.append(contentsOf: newItems)
        
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([TodoItem].self, from: data)
        else { return }
        
        items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }

    func moveItem(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
        print("moved from \(source) to \(destination)")
    }
    
    func addItem(title: String) {
        items.append(TodoItem(title: title, isCompleted: false))
    }
    
    // MARK: firstIndex() is THE IDIOMATIC WAY TO FIND AND EDIT AN ITEM BY ID — IT DOESN'T GET SIMPLER THAN THIS
    
    // MARK: this is just like ForEach: firstIndex will iterate through all the elements in items, and for each iteration, it will pass in the current item into the where closure as an ARGUMENT ($0)
    
    func toggleItem(_ item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
//            let id = items[index].id
//            let title = items[index].title
//            let isCompleted = !items[index].isCompleted
//
            let updatedItem = item.updateItem()
            let destination = updatedItem.isCompleted ? items.count - 1 : 0
            items.remove(at: index)
            items.insert(updatedItem, at: destination)
        }
    }
    
    // TODO: make this work!
//    func moveItemToBottom(from source: Int) {
//        let sourceSet = IndexSet(integer: source)
//        let destination = items.count - 1
//        moveItem(from: sourceSet, to: destination)
//    }
    
    func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: itemsKey)
        }
    }
}
