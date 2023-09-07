//
//  login.swift
//  ios-dev
//
//  Created by Housu Zhang on 7/9/2023.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @EnvironmentObject var userAuth : UserAuth
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""

    var body: some View {
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
            
            Button(action: signIn) {
                Text("Sign In")
            }
            
            NavigationLink(destination: RegisterView()){
                Text("Don't have an account? Register")
            }
        }
        .padding()
    }

    func signIn() {
        userAuth.signIn(email: email, password: password) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
