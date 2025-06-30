//
//  SignInEmailView.swift
//  monkeyfire
//
//  Created by Matthew Fang on 6/4/25.
//

import SwiftUI

// TODO: LEARN CONCURRENCY LEARN CONCURRENCY LEARN CONCURRENCY!

enum signInError: Error {
    case emptyEmailOrPassword
    case invalidPassword
}



struct SignInEmailView: View {
    @State private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
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
                Task {
                    do {
                        try await viewModel.signUp()
                        showSignInView = false
                        print("signed up!")
                        return
                    } catch signInError.emptyEmailOrPassword {
                        viewModel.alertMessage = "Please enter both an email and a password!"
                        viewModel.alertIsShown = true
                    } catch {
                        print("sign in failed")
                    }
                    
                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                        print("signed in!")
                        return
                    } catch signInError.emptyEmailOrPassword {
                        viewModel.alertMessage = "Please enter both an email and a password!"
                        viewModel.alertIsShown = true
                    } catch {
                        viewModel.alertMessage = "Your password was incorrect! Please try again."
                        viewModel.alertIsShown = true
                    }
                }
                
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
        .alert("attention!", isPresented: $viewModel.alertIsShown) {
            Button("ok", role: .cancel) {}
        } message: {
            Text(viewModel.alertMessage)
        }
        .navigationTitle("Sign In with Email")
        
        Spacer()
    }
}

#Preview {
    NavigationStack {
        SignInEmailView(showSignInView: .constant(true))
    }
}
