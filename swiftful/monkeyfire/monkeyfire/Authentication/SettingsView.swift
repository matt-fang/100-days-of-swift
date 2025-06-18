//
//  SettingsView.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/4/25.
//

import Observation
import SwiftUI

@MainActor
@Observable
final class SettingsViewModel {
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
}

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    @State private var username: String? = nil
    @State private var userId: String? = nil

    var body: some View {
        List {
            Section(header: Text("User info")) {
                Text("Your user id is \(userId ?? "unknown")")
                Text("you are very cool!")
            }
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
            username = viewModel.getUser().username
            userId = viewModel.getUser().userId
        }
        .onAppear {
            username = viewModel.getUser().username
            userId = viewModel.getUser().userId
        }
        .navigationTitle("Hi \(username ?? "there")!")
    }
}

#Preview {
    NavigationStack {
        // MARK: what's .constant? -> it returns a binding<bool> for whenever you need one as an argument

        SettingsView(showSignInView: .constant(false))
    }
}
