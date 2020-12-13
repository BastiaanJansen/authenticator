//
//  ScanQRCodeView.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI
import CarBode
import AVFoundation

struct ScanQRCodeView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var scanQRCodeVM = ScanQRCodeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if !scanQRCodeVM.showAddAccountView {
                    CBScanner(
                        supportBarcode: .constant([.qr]),
                        scanInterval: .constant(2.0)
                    ){
                        scanQRCodeVM.foundBarcode(value: $0.value)
                    }
                    .cornerRadius(20)
                    .padding()
                }
                 
                NavigationLink(destination: (scanQRCodeVM.account != nil) ? AddAccountView(addAccountVM: AddAccountViewModel(account: scanQRCodeVM.account!)) : AddAccountView(), isActive: $scanQRCodeVM.showAddAccountView) {
                    Text("Enter code manually")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            Rectangle()
                                .foregroundColor(.accentColor)
                                .cornerRadius(10)
                                .frame(width: 200)
                    )
                }
            }
            .onReceive(scanQRCodeVM.publisher, perform: { account in
                self.scanQRCodeVM.showAddAccountView = true
            })
            .padding(.bottom)
            .navigationTitle("Scan QR code")
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
            )
        }
    }
}

struct ScanQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScanQRCodeView()
    }
}
