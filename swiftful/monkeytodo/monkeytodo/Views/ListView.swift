//
//  ListView.swift
//  monkeytodo
//
//  Created by Matthew Fang on 6/9/25.
//

import SwiftUI

struct ListView: View {
    
    @Environment(ListViewModel.self) private var viewModel

    var body: some View {
//        List($items, editActions: .all) { $item in
//            ListRowView(task: item)
        
        List() {
            ForEach(viewModel.items) { item in
                ListRowView(task: item)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            viewModel.toggleItem(item)
                        }
                    }
            }
            // MARK: swift magic lets us not pass in any arguments to our closure argument (even though .onDelete() DOES pass in an argument behind the scenes)
            .onDelete(perform: viewModel.deleteItem)
            .onMove(perform: viewModel.moveItem)
        }
    
        .listStyle(PlainListStyle())
        .navigationTitle("monkeytodo")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink {
                    AddTaskView()
                } label: {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListView()
    }
    .environment(ListViewModel())
}
