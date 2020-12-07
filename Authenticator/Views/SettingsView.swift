//
//  SettingsView.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI
import LocalAuthentication

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var settingsVM = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    if let type = AuthenticatorApp.biometricType() {
                        Toggle(type == BiometricType.faceID ? "Face ID" : "Touch ID", isOn: $settingsVM.biometricAuthenticationIsEnabled)
                        
                        if settingsVM.biometricAuthenticationIsEnabled {
                            Toggle("Auto lock", isOn: $settingsVM.autoLockIsEnabled)
                        }
                    }
                    
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                }
            )
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
