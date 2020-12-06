//
//  ScanQRCodeView.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI

struct ScanQRCodeView: View {
    @ObservedObject var scanQRCodeVM = ScanQRCodeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Button(action: {
                    self.scanQRCodeVM.showAddAccountView.toggle()
                }) {
                    Text("Enter code manually")
                }.sheet(isPresented: self.$scanQRCodeVM.showAddAccountView) {
                    AddAccountView()
                }
            }.navigationTitle("Scan QR Code")
        }
    }
}

struct ScanQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScanQRCodeView()
    }
}
