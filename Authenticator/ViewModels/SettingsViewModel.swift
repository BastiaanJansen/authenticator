//
//  SettingsViewModel.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import SwiftKeychainWrapper
import LocalAuthentication

class SettingsViewModel: ObservableObject {
    @Published var biometricAuthenticationIsEnabled: Bool {
        didSet {
            UserDefaults.standard.set(biometricAuthenticationIsEnabled, forKey: "BiometricAuthenticationIsEnabled")
        }
    }
    
    @Published var autoLockIsEnabled: Bool {
        didSet {
            UserDefaults.standard.set(autoLockIsEnabled, forKey: "AutoLockIsEnabled")
        }
    }

    
    init() {
        self.biometricAuthenticationIsEnabled = UserDefaults.standard.bool(forKey: "BiometricAuthenticationIsEnabled")
        self.autoLockIsEnabled = UserDefaults.standard.bool(forKey: "AutoLockIsEnabled")
    }
}
