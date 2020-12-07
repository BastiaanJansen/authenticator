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
    
    init() {
        UserDefaults.standard.register(defaults: [
            "BiometricAuthenticationIsEnabled": false,
            "AutoLockIsEnabled": false,
        ])
    }

    var body: some Scene {
        WindowGroup {
            StartView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onOpenURL(perform: { url in
                    print("URL deeplink")
            })
        }
    }
    
    static func biometricType() -> BiometricType {
        let authContext = LAContext()
        if #available(iOS 11, *) {
            let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch(authContext.biometryType) {
            case .none:
                return BiometricType.none
            case .touchID:
                return BiometricType.touchID
            case .faceID:
                return BiometricType.faceID
            @unknown default:
                return BiometricType.none
            }
        } else {
            return authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
        }
    }
}

enum BiometricType {
    case none
    case touchID
    case faceID
}
