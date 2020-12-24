//
//  HomeView.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var homeVM = HomeViewModel()

    let pasteboard = UIPasteboard.general
    let hapticGenerator = UIImpactFeedbackGenerator(style: .light)

    var body: some View {
        NavigationView {
            List {
                ForEach(homeVM.accounts) { account in                    
                    AccountRow(account: account).onTapGesture {
                        pasteboard.string = account.generateCode()
                        hapticGenerator.impactOccurred()
                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Authenticator")
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.homeVM.showSettingsView.toggle()
                    }) {
                        Image(systemName: "gear").resizable().frame(width: Constants.navigationBarIconSize, height: Constants.navigationBarIconSize)
                    }.sheet(isPresented: $homeVM.showSettingsView) {
                        SettingsView()
                    },
                trailing:
                    Button(action: {
                        self.homeVM.showScanQRCodeView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: Constants.navigationBarIconSize, height: Constants.navigationBarIconSize)
                    }.sheet(isPresented: $homeVM.showScanQRCodeView) {
                        let scanQRCodeVM = ScanQRCodeViewModel()
                        ScanQRCodeView(scanQRCodeVM: scanQRCodeVM)
                            .onReceive(scanQRCodeVM.publisher, perform: { account in

                            })

                    })
        }
    }
        
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            homeVM.delete(account: homeVM.accounts[index])
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        HomeView().preferredColorScheme(.dark)
//        HomeView().previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
