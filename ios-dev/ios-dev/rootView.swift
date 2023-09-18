//
//  rootView.swift
//  ios-dev
//
//  Created by Housu Zhang on 7/9/2023.
//

import SwiftUI
import Firebase

struct RootView: View {
    @EnvironmentObject var userAuth : UserAuth
    
    var body: some View{
        Group {
            if (userAuth.isLoggedIn) {
                MainPage()
            } else {
                LoginView()
            }
        }
    }
}
