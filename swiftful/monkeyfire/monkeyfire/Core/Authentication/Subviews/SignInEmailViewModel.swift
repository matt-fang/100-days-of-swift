//
//  SignInEmailViewModel.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/30/25.
//

import Foundation
import Observation

@MainActor
@Observable
final class SignInEmailViewModel {
    var email = ""
    var password = ""
    
    var alertIsShown: Bool = false
    var alertMessage: String = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw signInError.emptyEmailOrPassword
        }
        
        try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw signInError.emptyEmailOrPassword
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
