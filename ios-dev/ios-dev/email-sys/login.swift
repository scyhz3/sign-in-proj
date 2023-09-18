//
//  login.swift
//  ios-dev
//
//  Created by Housu Zhang on 7/9/2023.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userAuth : UserAuth
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var error: CustomError? = nil {
        willSet {
            showError = newValue != nil
        }
    }
    @State private var showError = false

    var body: some View {
        NavigationView {  // Add this line
            Form {
                Section("Login Info") {
                    TextField("Email", text: $email)
                        .autocapitalization(.none)

                    SecureField("Password", text: $password)
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
                
                Button(action:{
                    Task {
                        await signIn()
                    }
                }){
                    Text("Login")
                }
                .alert(isPresented: $showError, error: error) {}
                
                
                NavigationLink(destination: RegisterView()){
                    Text("Don't have an account? Register")
                        .foregroundColor(.blue)
                }
                
                Button(action: {
                    Task {
                        userAuth.googleSignIn()
                    }
                }){
                    HStack {
                        Image("Google") // Correct the image name here
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                        Text("Sign in with Google")
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
        }
    }
    
    func signIn() async {
        do {
            try await userAuth.signIn(email: email, password: password)
        } catch {
            self.error = .registerError(error.localizedDescription)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
