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
                Section(header: Text("Security")) {
                    if let type = AuthenticatorApp.biometricType() {
                        Toggle(type == BiometricType.faceID ? "Face ID" : "Touch ID", isOn: $settingsVM.biometricAuthenticationIsEnabled)
                        
                        if settingsVM.biometricAuthenticationIsEnabled {
                            Toggle("Auto lock", isOn: $settingsVM.autoLockIsEnabled)
                        }
                    }
                }
                
                Section(footer: Text("Allow iOS widgets to show authorization codes. If enabled anyone with access to your phone can see authorization codes.")) {
                    Toggle("Widgets", isOn: $settingsVM.widgetsAreEnabled)
                }
                
                Section(header: Text("Appearance")) {
                    NavigationLink(destination:
                        HStack {
                            Text("Change app icon")
                        }.navigationTitle("App icon")
                    ) {
                        Text("App icon")
                    }
                }
                
                Section(header: Text("About")) {
                    Button(action: {
                        URL.open(link: URL.Link.github)
                    }) {
                        Text("GitHub")
                    }
                    
                    HStack {
                        Text("Version: \(settingsVM.getAppVersion() ?? "unknown")").font(.system(size: 12))
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
