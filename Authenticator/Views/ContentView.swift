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

    @FetchRequest(entity: Account.entity(), sortDescriptors: []) var accounts: FetchedResults<Account>
    
    @ObservedObject var homeVM = HomeViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(accounts) { account in
                    AccountRow(account: account)
                }
                .onDelete(perform: delete)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Authenticator").navigationBarItems(trailing:
                Button(action: {
                    self.homeVM.showScanQRCodeView.toggle()
                }) {
                    Image(systemName: "plus.circle.fill").resizable().frame(width: 30, height: 30)
                }.sheet(isPresented: $homeVM.showScanQRCodeView) {
                    ScanQRCodeView()
                }
            )
        }.onAppear() {
            self.homeVM.context = viewContext
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            self.homeVM.delete(account: self.accounts[index])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
