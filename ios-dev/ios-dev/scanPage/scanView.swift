//
//  scanView.swift
//  ios-dev
//
//  Created by Housu Zhang on 7/9/2023.
//

import SwiftUI

struct ScanView: View {
    @State var scanResult = "No QR code detected"
    @Binding var isPresented: Bool  // Add this line
 
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
                    isPresented = false  // Update this line
                }) {
                    Text("Quit")
                }
            }
        }
    }
}

struct Scan_Preivews: PreviewProvider {
    @State static var isPresented = true // Add this line

    static var previews: some View {
        ScanView(isPresented: $isPresented) // Update this line
    }
}
