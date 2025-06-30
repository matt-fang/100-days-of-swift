//
//  SettingsViewModel.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/30/25.
//

import Observation
import SwiftUI

// MARK: YOU SHOULD ALWAYS BE CALLING ALL MANAGER/SERVICE FUNCFTIONS IN THE VIEWMODEL!!

@MainActor
@Observable final class SettingsViewModel {
    var authProviders: [AuthProviderOption] = []

    func getUser() -> (username: String?, userId: String?, email: String?) {
        do {
            let user = try AuthenticationManager.shared.getAuthenticatedUser()
            let email = user.email
            let username = user.email?.components(separatedBy: "@")[0]
            let userId = user.uid

            return (username, userId, email)

        } catch {
            print("no user!")
            return (nil, nil, nil)
        }
    }

    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }

    func resetPassword() async throws {
        guard let email = getUser().email else {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }

        try await AuthenticationManager.shared.resetPassword(email: email)
    }

    func updatePassword() async {
        do {
            try await AuthenticationManager.shared.updatePassword(password: "testpassword123")
        } catch {
            print(error)
        }
    }

    func updateEmail() async {
        do {
            try await AuthenticationManager.shared.updateEmail(email: "matthew.fang@valleychristianschools.org")
        } catch {
            print(error)
        }
    }

    func getAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProvider() {
            self.authProviders = providers
        }
    }
}
