//
//  monkeyfireApp.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/3/25.
//

import Firebase
import SwiftUI


@main
struct monkeyfireApp: App {
    init() {
        FirebaseApp.configure()
        print("configured firebase!")
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
