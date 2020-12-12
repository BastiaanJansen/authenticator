//
//  StartViewModel.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import LocalAuthentication
import SwiftKeychainWrapper

class StartViewModel: ObservableObject {
    
    @Published var isUnlocked: Bool = false
    
    init() {
        let shouldAuthenticate = self.shouldAuthenticate()
        if shouldAuthenticate {
            authenticateBiometric()
        } else {
            isUnlocked = true
        }
    }
    
    func shouldAuthenticate() -> Bool {
        let biometricAuthenticationIsEnabled: Bool = UserDefaults.standard.bool(forKey: "BiometricAuthenticationIsEnabled")
        return biometricAuthenticationIsEnabled
    }
    
    func authenticateBiometric() {
        let authService = BiometricAuthService(reason: "Use biometrics to unlock your data")
        
        authService.authenticate { (success, error) in
            DispatchQueue.main.async {
                if success {
                    self.isUnlocked = true
                }
            }
        }
    }
}
