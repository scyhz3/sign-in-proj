//
//  mian.swift
//  ios-dev
//
//  Created by Housu Zhang on 7/9/2023.
//

import SwiftUI

struct MainPage: View {
    @EnvironmentObject var userAuth: UserAuth
    @State private var showingScanView = false
    @State private var scanResult = "No QR code detected"

    var body: some View {
        VStack {
            Text("Welcome to the main page")

            // Add this line to display the scan result
            Text("Scan result: \(scanResult)")
                .frame(height: 100)
                .foregroundColor(.green)

            Button(action: {
                userAuth.signOut()
            }) {
                Text("Sign Out")
                    .frame(width: 100, height: 100)
            }

            Button(action: {
                showingScanView = true
            }) {
                Text("Scan the qr code")
            }
        }
        .sheet(isPresented: $showingScanView) {
                ScanView(isPresented: $showingScanView, scanResultForMainPage: $scanResult)
        }
    }
}

struct MainPage_Preivews: PreviewProvider {
    static var previews: some View {
        MainPage().environmentObject(UserAuth())
    }
}
