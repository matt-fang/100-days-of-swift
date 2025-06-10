//
//  SignInEmailView.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/4/25.
//

import Observation
import SwiftUI

// TODO: LEARN CONCURRENCY LEARN CONCURRENCY LEARN CONCURRENCY!

@MainActor
@Observable
final class SignInEmailViewModel {
    var email = ""
    var password = ""
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            print("no password or email!")
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("success \(returnedUserData)")
            } catch {
                print("Error")
            }
        }
        
    }
}

struct SignInEmailView: View {
    @State private var viewModel = SignInEmailViewModel()
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
            Button {
                viewModel.signIn()
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Sign In with Email")
        
        Spacer()
    }
}

#Preview {
    NavigationStack {
        SignInEmailView()
    }
}
