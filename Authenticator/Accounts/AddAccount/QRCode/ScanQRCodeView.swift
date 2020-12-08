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
                CBScanner(
                    supportBarcode: .constant([.qr]),
                    scanInterval: .constant(2.0)
                ){
                    let url = URL(string: $0.value)
                    if let url = url {
                        self.scanQRCodeVM.foundBarcode(url: url)
                        
                        if self.scanQRCodeVM.accountCreated {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .cornerRadius(20)
                .padding()
                 
                Button(action: {
                    self.scanQRCodeVM.showAddAccountView.toggle()
                }) {
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
                .sheet(isPresented: self.$scanQRCodeVM.showAddAccountView, onDismiss: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    AddAccountView()
                }
            }
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
        .onAppear() {
            self.scanQRCodeVM.context = viewContext
        }
    }
}

struct ScanQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScanQRCodeView()
    }
}
