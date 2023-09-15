//
//  scanView.swift
//  ios-dev
//
//  Created by Housu Zhang on 7/9/2023.
//

import SwiftUI

struct ScanView: View {
    @State var scanResult = "No QR code detected"
    @Binding var isPresented: Bool
    @Binding var scanResultForMainPage: String

    var body: some View {
        ZStack(alignment: .bottom) {
            QRScanner(result: $scanResult)

            HStack {
                Text(scanResult)
                    .padding()
                    .background(.black)
                    .foregroundColor(.white)
                    .padding(.bottom)

                Button(action: {
                    print(scanResult)
                    isPresented = false
                }) {
                    Text("Quit")
                }
            }
        }
        .onChange(of: scanResult) { newValue in
            if newValue != "No QR code detected" {
                scanResultForMainPage = newValue  
                isPresented = false
            }
        }
    }
}
