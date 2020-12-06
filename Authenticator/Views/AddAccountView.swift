//
//  AddAccountView.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI

struct AddAccountView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var addAccountVM: AddAccountViewModel
    
    init(addAccountVM: AddAccountViewModel = AddAccountViewModel()) {
        self.addAccountVM = addAccountVM
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Base options")) {
                    TextField("Service", text: $addAccountVM.service)
                    TextField("Name", text: $addAccountVM.name)
                    TextField("Key", text: $addAccountVM.key)
                }
            }
            .navigationTitle("Add account")
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
            })
            .navigationBarItems(trailing: Button(action: {
                self.addAccountVM.add()
            }) {
                Text("Save")
            })
        }.onAppear() {
            self.addAccountVM.context = viewContext
        }
    }
}

struct AddAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountView()
    }
}
