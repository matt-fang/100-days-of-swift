//
//  RootView.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/4/25.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView = false

    var body: some View {
        ZStack {
            NavigationStack {
                SettingsView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        // MARK: you can pass + modify a isPresented binding instead of using Environment dismiss! (at least for temporary views like sign in)
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
