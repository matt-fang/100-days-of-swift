//
//  AuthenticationView.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/4/25.
//

import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

// TODO: UNDERSTAND MAIN ACFTOR
@MainActor
final class AuthenticationViewModel {
    func signInGoogle() async throws -> GoogleSignInResultModel {
//        let helper = SignInGoogleHelper()
        let tokens = try await SignInGoogleHelper.signIn()

        // MARK: always bundle API results (AuthDataResult, GoogleSignInResult, etc) into a convenient model struct!!!

        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        
        return tokens
    }
}

struct AuthenticationView: View {
    @State var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    @Binding var username: String?

    var body: some View {
        VStack {
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding()
            }
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    do {
                        username = try await viewModel.signInGoogle().name
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            }
            Spacer()
        }
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        AuthenticationView(showSignInView: .constant(true), username: .constant("MonkeyIsCool1234"))
    }
}
