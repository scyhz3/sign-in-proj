//
//  mian.swift
//  ios-dev
//
//  Created by Housu Zhang on 7/9/2023.
//

import SwiftUI

struct MainPage: View{
    @EnvironmentObject var userAuth: UserAuth
    
    var body: some View{
        VStack {
            Text("Welcome to the main page")
            
            Button(action: {
                userAuth.signOut()
            }) {
                Text("Sign Out")
                    .frame(width: 100, height: 100)
            }
        }
    }
}

struct MainPage_Preivews: PreviewProvider {
    static var previews: some View {
        MainPage().environmentObject(UserAuth())
    }
}
