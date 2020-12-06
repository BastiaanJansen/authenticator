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
        ZStack {
            GeometryReader { geo in
                CBScanner(
                    supportBarcode: .constant([.qr]),
                    scanInterval: .constant(2.0)
                ){
                    self.scanQRCodeVM.foundBarcode(value: $0.value)
                }

                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancel")
                                .foregroundColor(.black)
                                .font(.system(size: 14))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .frame(width: geo.size.width / 2 - 30))
                        }
                        
                        Button(action: {
                            self.scanQRCodeVM.showAddAccountView.toggle()
                        }) {
                            Text("Enter code manually")
                                .foregroundColor(.black)
                                .font(.system(size: 14))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .frame(width: geo.size.width / 2 - 30))
                        }
                        .sheet(isPresented: self.$scanQRCodeVM.showAddAccountView, onDismiss: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            AddAccountView()
                        }
                    }
                }.padding(.bottom, 50)
            }
        }
        .ignoresSafeArea(.all, edges: .all)
        .onAppear() {
            self.scanQRCodeVM.context = viewContext
        }
        .onReceive(scanQRCodeVM.viewDismissalModePublisher) { shouldDismiss in
            print(shouldDismiss)
            if shouldDismiss {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ScanQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScanQRCodeView()
    }
}
