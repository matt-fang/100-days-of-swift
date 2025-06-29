//
//  SettingsView.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/4/25.
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

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
//    @State private var username: String? = nil
    @State private var userId: String? = nil
    @Binding var username: String?

    var body: some View {
        List {
            Section(header: Text("User info")) {
                Text("Your user id is \(userId ?? "unknown")")
                Text("you are very cool!")
            }
            if viewModel.authProviders.contains(AuthProviderOption.email) {
                Section {
                    Button("Reset password") {
                        Task {
                            do {
                                try await viewModel.resetPassword()
                            } catch {
                                print("email not found")
                            }
                        }
                    }
                    Button("Update password") {
                        Task {
                            await viewModel.updatePassword()
                        }
                    }
                    Button("Update email") {
                        Task {
                            await viewModel.updateEmail()
                        }
                    }
                }
            }
            Section {
                Button("Log out", role: .destructive) {
                    do {
                        try viewModel.logOut()
                        print("logged out")
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .onChange(of: showSignInView) {
//            username = viewModel.getUser().username
            // TODO: IS IT BETTER TO GET NAME + USERID FROM getUser() or FROM THE AUTHVIEW LOG IN TOKENS????
            // TODO: i think getUser() because the tokens only work ON log in?? username is just nil if you close the app and reopen
            userId = viewModel.getUser().userId
            viewModel.getAuthProviders()
        }
        .onAppear {
//            username = viewModel.getUser().username
            userId = viewModel.getUser().userId

        }
        .navigationTitle("Hi \(username ?? "there")!")
    }
}

#Preview {
    NavigationStack {
        // MARK: what's .constant? -> it returns a binding<bool> for whenever you need one as an argument

        SettingsView(showSignInView: .constant(false), username: .constant("MonkeyIsCool1234"))
    }
}
