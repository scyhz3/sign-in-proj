//
//  register.swift
//  ios-dev
//
//  Created by Housu Zhang on 7/9/2023.
//


import SwiftUI
import Firebase

struct RegisterView : View {
    
    @EnvironmentObject var userAuth : UserAuth
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack {
            registrationForm
        }
    }
    
    @ViewBuilder
    private var registrationForm: some View {
        @EnvironmentObject var userAuth : UserAuth
        Form {
            Section("Register Info"){
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage).foregroundColor(.red)
                }
            }
            
            Button(action: register) {
                Text("Register")
            }
        }
    }
    
    func register() {
        userAuth.register(email: email, password: password) { error
            in
            if let error = error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}


struct RegisterView_Preview: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
