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

    // MARK: SIGN OUT IS IMMEDIATE! one of the only non-async functions in firebase (for good reason!)
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
