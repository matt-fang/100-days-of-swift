//
//  monkeytodoApp.swift
//  monkeytodo
//
//  Created by Matthew Fang on 6/8/25.
//

import SwiftUI

@main
struct monkeytodoApp: App {
    // TODO: we can make this a private var for some reason???
    @State var listViewModel = ListViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ListView()
                    .navigationTitle("monkeytodo")
            }
            .environment(listViewModel)
        }
    }
}
