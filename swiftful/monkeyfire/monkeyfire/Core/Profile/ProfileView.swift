//
//  ProfileView.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/30/25.
//

import SwiftUI
import Observation

@MainActor
@Observable final class ProfileViewModel {
    
    private(set) var user: AuthDataResultModel? = nil
    
    func loadUser() throws {
        self.user = try  AuthenticationManager.shared.getAuthenticatedUser()
    }
}

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text(user.uid)
            }
        }
        .onAppear {
            try? viewModel.loadUser()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, ) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false))
    }
}
