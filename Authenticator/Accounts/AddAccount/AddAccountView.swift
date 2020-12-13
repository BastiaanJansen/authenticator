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
                    TextField("Service", text: $addAccountVM.issuer)
                    TextField("Name", text: $addAccountVM.name)
                    TextField("Key", text: $addAccountVM.issuer)
                }
                
                Section(header: Text("Advanced options"), footer: Text("If you are not familiar with these options, do not change them. Otherwise, the generated code will not work.")) {
                    Toggle(isOn: $addAccountVM.showAdvancedOptions) {
                        Text("Advanced options")
                    }.toggleStyle(SwitchToggleStyle(tint: .accentColor))
                    
                    if addAccountVM.showAdvancedOptions {
                        Group {
                            HStack {
                                Text("Algorithm")
                                Picker("", selection: $addAccountVM.algorithm) {
                                    ForEach(Algorithm.allCases, id: \.self) { algorithm in
                                        Text(algorithm.rawValue)
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                            
                            HStack {
                                Text("Digits")
                                Picker("", selection: $addAccountVM.digits) {
                                    ForEach(Digit.allCases, id: \.self) { digit in
                                        Text(String(digit.rawValue))
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                            
                            HStack {
                                Text("Interval")
                                Spacer()
                                TextField("", value: $addAccountVM.timeInterval, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    }
                }
            }
            .gesture(DragGesture().onChanged { _ in
                self.hideKeyboard()
            })
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
        }
    }
}

struct AddAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountView()
    }
}
