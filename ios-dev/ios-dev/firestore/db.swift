//
//  db.swift
//  ios-dev
//
//  Created by Housu Zhang on 18/9/2023.
//


import FirebaseFirestore

class SignInManager : ObservableObject {
    private let db = Firestore.firestore()
    private let userID: String
    @Published var signInStatus: SignInStatus = .notSignedIn

    enum SignInStatus {
        case notSignedIn
        case signingIn
        case signedIn
        case error(Error)
    }

    init(userID: String) {
        self.userID = userID
        checkSignInStatus()
    }

    private func checkSignInStatus() {
        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        let todayString = formatter1.string(from: today)
        
        let docRef = db.collection("signInRecords").document(userID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let signInData = document.data() {
                    if signInData[todayString] as? String == "yes" {
                        self.signInStatus = .signedIn
                    } else {
                        self.signInStatus = .notSignedIn
                    }
                }
            } else {
                self.signInStatus = .notSignedIn
            }
        }
    }
    
    func signIn(completion: @escaping (Error?) -> Void) {
        signInStatus = .signingIn
        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        let todayString = formatter1.string(from: today)
        
        let docRef = db.collection("signInRecords").document(userID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let signInData = document.data() {
                    if signInData[todayString] as? String == "yes" {
                        // Already signed in today
                        completion(nil)
                    } else {
                        // Sign in
                        docRef.setData([todayString: "yes"], merge: true) { err in
                            completion(err)
                        }
                    }
                } else {
                    // The document data was nil
                    print("Document data was nil.")
                }
            } else {
                // First time sign in
                docRef.setData([todayString: "yes"], merge: true) { err in
                    if let err = err {
                        self.signInStatus = .error(err)
                    } else {
                        self.signInStatus = .signedIn
                    }
                    completion(err)
                }
            }
        }
    }
}



extension SignInManager {
    var signInStatusText: String {
        switch signInStatus {
        case .notSignedIn:
            return "Not signed in"
        case .signingIn:
            return "Signing in..."
        case .signedIn:
            return "Signed in!"
        case .error(let error):
            return "Error: \(error.localizedDescription)"
        }
    }
}


