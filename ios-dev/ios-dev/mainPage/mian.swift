//
//  mian.swift
//  ios-dev
//
//  Created by Housu Zhang on 7/9/2023.
//

import SwiftUI
import Firebase
import SystemConfiguration.CaptiveNetwork



struct MainPage: View {
    @EnvironmentObject var userAuth: UserAuth
    @State private var showingScanView = false
    @State private var scanResult = "No QR code detected"
    @StateObject private var signInManager = SignInManager(userID: Auth.auth().currentUser?.uid ?? "")
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            Text("Welcome to the main page")

            Text("Latitude: \(locationManager.location?.coordinate.latitude ?? 0)")
            Text("Longitude: \(locationManager.location?.coordinate.longitude ?? 0)")
            // Add this line to display the scan result
//            Text("Scan result: \(scanResult)")
//                .frame(height: 100)
//                .foregroundColor(.green)
            Text(scanResult)
                .frame(height: 100)
                .foregroundColor(.green)

            // Add this line to display the sign-in status
            Text("Sign-in status: \(signInManager.signInStatusText)")
                .frame(height: 100)
                .foregroundColor(.red)

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
        .onChange(of: scanResult) { newValue in
            if newValue == "hello world" {
                signInManager.signIn { error in
                    if let error = error {
                        print("Error signing in: \(error)")
                    } else {
                        print("Successfully signed in!")
                    }
                }
            }
        }
        .onAppear {
            locationManager.start()
        }
    }
}

struct MainPage_Preivews: PreviewProvider {
    static var previews: some View {
        MainPage().environmentObject(UserAuth())
    }
}
