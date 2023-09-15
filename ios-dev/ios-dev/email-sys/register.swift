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
    @State private var error: CustomError? = nil {
        willSet {
            showError = newValue != nil
        }
    }
    @State private var showError = false
    
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
            
            Button(action:{
                Task {
                    await register()
                }
            }) {
                Text("Register")
            }
        }
        .alert(isPresented: $showError, error: error) {}
    }
    
    func register() async {
        do {
            try await userAuth.register(email: email, password: password)
        } catch {
            self.error = .registerError(error.localizedDescription)
        }
    }
}


struct RegisterView_Preview: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
