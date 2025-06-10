//
//  NoTabsView.swift
//  monkeytodo
//
//  Created by Matthew Fang on 6/10/25.
//

import SwiftUI

struct NoItemsView: View {
    @State var animate: Bool = false

    var body: some View {
        VStack(spacing: 6) {
            Text("no items :o")
                .font(.title)
                .fontWeight(.semibold)
            Text("add your first todo item by clicking the add button below!")
            NavigationLink {
                AddTaskView()
            } label: {
                Label("Add a task", systemImage: "plus")
                    .font(.headline)
                    .padding(animate ? 4 : 6)
            }
            .scaleEffect(animate ? 1.05 : 1.0)
            .offset(y: animate ? -2 : 0)
            .frame(height: 44)
            .buttonStyle(.borderedProminent)
            .tint(animate ? Color.teal : Color.blue)
            .padding()
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(40)
        .onAppear(perform: addAnimation)
    }

    func addAnimation() {
        guard !animate else { return }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation.easeInOut(duration: 1.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoItemsView()
            .navigationTitle(Text("monkeytodo"))
    }
}
