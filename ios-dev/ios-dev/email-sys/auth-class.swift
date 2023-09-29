//
//  auth-class.swift
//  ios-dev
//
//  Created by Housu Zhang on 7/9/2023.
//

import SwiftUI
import Firebase

enum CustomError: LocalizedError {
    case registerError(String)
    
    var errorDescription: String? {
        switch self {
        case .registerError(let reason):
            return "Unable to register user due to: \(reason)"
        }
    }
}

@MainActor
class UserAuth: ObservableObject {
    @Published var isLoggedIn = false
    private var google = AuthenticationViewModel()
    
    init() {
        isLoggedIn = Auth.auth().currentUser != nil
    }

    func signIn(email: String, password: String) async throws {
        let auth = Auth.auth()
        let result = try await auth.signIn(withEmail: email, password:  password)
        print(result)
        self.isLoggedIn = true
    }
    
    func googleLogIn() {
        Task {
            let success = await google.signInWithGoogle()
            if success {
                isLoggedIn = true
            } else {
                print("Failed to sign in.")
            }
        }
    }
    
    
    func register(email: String, password: String) async throws {
        let auth = Auth.auth()
        let result = try await auth.createUser(withEmail: email, password: password)
        print(result)
        self.isLoggedIn = true
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch {
            print("Failed to sign out.")
        }
    }
}
