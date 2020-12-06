//
//  ContentView.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var homeViewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            List(homeViewModel.accounts) { account in
                AccountRow(account: account)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Authenticator").navigationBarItems(trailing:
                Button(action: {
                    self.homeViewModel.showScanQRCodeView.toggle()
                }) {
                    Image(systemName: "plus.circle.fill").imageScale(.large)
                }.sheet(isPresented: $homeViewModel.showScanQRCodeView) {
                    ScanQRCodeView()
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
