//
//  monkeycryptoApp.swift
//  monkeycrypto
//
//  Created by Matthew Fang on 6/16/25.
//

import SwiftUI

@main
struct monkeycryptoApp: App {
    
    @State private var viewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .environment(viewModel)
    }
}
