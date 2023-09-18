//
//  google-login.swift
//  ios-dev
//
//  Created by Housu Zhang on 15/9/2023.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import GoogleSignInSwift

enum AuthenticationError: Error {
    case tokenError(message: String)
}

class AuthenticationViewModel: ObservableObject {
    @Published var isGoogleLoggedIn = false
    
    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase configuration")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScene.windows.first,
              let rootViewController = await window.rootViewController else {
            print("There is no root view controller")
            return false
        }
        
        do {
            let userAuentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuentication.user
            guard let idToken = user.idToken else {
                throw AuthenticationError.tokenError(message: "ID token missing")
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "Unknow")")
            isGoogleLoggedIn = true
            return true
        }
        catch{
            print(error.localizedDescription)
            return false
        }
    }
    
//    func signOutWithGoogle() {
//        GIDSignIn.sharedInstance().signOut()
//    }
//    
}
