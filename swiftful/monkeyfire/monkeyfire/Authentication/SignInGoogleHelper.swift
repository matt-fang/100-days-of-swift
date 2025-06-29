//
//  File.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/28/25.
//

import Foundation
import GoogleSignIn

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
}

final class SignInGoogleHelper {
    
    // MARK: use static func (@staticmethod in python) whenever the function doesn't depend on the object — if it's just a TOOL you know
    @MainActor
    static func signIn() async throws -> GoogleSignInResultModel {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }

        let GIDSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)

        guard let idToken: String = GIDSignInResult.user.idToken?.tokenString else {
            throw URLError(.cannotFindHost)
        }
        let accessToken: String = GIDSignInResult.user.accessToken.tokenString
        let name = GIDSignInResult.user.profile?.name
        let email = GIDSignInResult.user.profile?.email
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        return tokens
    }
    
    
}
