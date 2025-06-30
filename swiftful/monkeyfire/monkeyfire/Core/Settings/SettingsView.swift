//
//  SettingsView.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/4/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
//    @State private var username: String? = nil
    @State private var userId: String? = nil
//    @Binding var username: String?

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
//        .navigationTitle("Hi \(username ?? "there")!")
        .navigationTitle("hi there!")
    }
}

#Preview {
    NavigationStack {
        // MARK: what's .constant? -> it returns a binding<bool> for whenever you need one as an argument

        SettingsView(showSignInView: .constant(false))
    }
}
