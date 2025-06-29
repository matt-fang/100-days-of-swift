//
//  AuthenticationManager.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/4/25.
//

import FirebaseAuth
import Foundation

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?

    init(user: User) {
        self.uid = user.uid

        // MARK: passing optional to optional doesn't need special treatment!

        // MARK: passing optional to NON-OPTINOAL requires a defualt value

        self.email = user.email

        // MARK: optional chaining - only call absoluetString if photoURL exists

        self.photoUrl = user.photoURL?.absoluteString
    }
}

enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
}

// TODO: LEARN DEPENDENCY INJETIOPN
final class AuthenticationManager {
    static let shared = AuthenticationManager()

    private init() {}

    // MARK: this is not async since WE ARE ABLE TO LOOK UP USERS ON THE LOCAL SDK (which is good - since we dont need to worry about loading screens)

    // MARK: this function throws cuz we CHOOSE for it to raise an error (using guard [condition] else throw [error]) if user == nil

    // MARK: note that Auth.auth().currentUser is just a regular getter - it does not throw, so we don't need try

    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }

        return AuthDataResultModel(user: user)
    }

    func getProvider() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData
        else {
            throw URLError(.badServerResponse)
        }

        var providers: [AuthProviderOption] = []

        for provider in providerData {
            if let providerOption = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(providerOption)
                print(providerOption)
            } else {
                assertionFailure("provider option not found: \(provider.providerID)")
            }
        }
        return providers
    }

    // MARK: SIGN OUT IS IMMEDIATE! one of the only non-async functions in firebase (for good reason!)

    func signOut() throws {
        try Auth.auth().signOut()
    }
}

// MARK: SIGN IN EMAIL

extension AuthenticationManager {
    // TODO: is the whole point of discardableResult to get rid of warnings when you don't use a function's return (SOMETIMES)?
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)

        return result
    }

    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }

    // MARK: Auth.auth().signOut() is a THROWING function, so we have to mark it with try

    // MARK: but since we marked OUR function with throws, we pass on the catching-responsibility one level up

    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }

        try await user.updatePassword(to: password)
    }

    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }

        try await user.sendEmailVerification(beforeUpdatingEmail: email)
    }
}

// MARK: SIGN IN SSO

extension AuthenticationManager {
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }

    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
