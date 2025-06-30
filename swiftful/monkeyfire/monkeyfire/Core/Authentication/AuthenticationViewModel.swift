//
//  AuthenticationViewModel.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/30/25.
//

import Foundation

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

