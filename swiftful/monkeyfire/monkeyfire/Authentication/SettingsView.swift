//
//  SettingsView.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/4/25.
//

import SwiftUI
import Observation

@MainActor
@Observable
final class SettingsViewModel {
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Log out") {
                do {
                    try viewModel.logOut()
                    showSignInView = true
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        // TODO: what's .constant?
        SettingsView(showSignInView: .constant(false))
    }
}
