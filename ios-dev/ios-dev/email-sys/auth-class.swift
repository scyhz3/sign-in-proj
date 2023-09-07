//
//  auth-class.swift
//  ios-dev
//
//  Created by Housu Zhang on 7/9/2023.
//

import SwiftUI
import Firebase

class UserAuth: ObservableObject {
    @Published var isLoggedIn = false

    init() {
        isLoggedIn = Auth.auth().currentUser != nil
    }

    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
            } else {
                self.isLoggedIn = true
                completion(nil)
            }
        }
    }

    func register(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
            } else {
                self.isLoggedIn = true
                completion(nil)
            }
        }
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
