//
//  RootView.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/4/25.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView = false
    @State private var username: String?

    var body: some View {
        ZStack {
            NavigationStack {
                ProfileView(showSignInView: $showSignInView)
//                SettingsView(showSignInView: $showSignInView, username: $username)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
            
        }
        // MARK: you can pass + modify a isPresented binding instead of using Environment dismiss! (at least for temporary views like sign in)
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView, username: $username)
            }
        }
    }
}

#Preview {
    RootView()
}
