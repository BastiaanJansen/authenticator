//
//  AuthenticatorApp.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI
import SwiftKeychainWrapper
import LocalAuthentication

@main
struct AuthenticatorApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.colorScheme) var colorScheme
    
    init() {
        UserDefaults.standard.set(defaultValues: [
            .biometricAuthenticationIsEnabled: false,
            .autoLockIsEnabled: false,
        ])
    }

    var body: some Scene {
        WindowGroup {
            StartView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onOpenURL(perform: { url in
                    print("URL deeplink")
                })
//            PasscodeView()
        }
    }
}
