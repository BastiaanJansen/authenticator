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
        print(shouldAuthenticate)
        if shouldAuthenticate {
            authenticateBiometric()
        } else {
            isUnlocked = true
        }
    }
    
    func shouldAuthenticate() -> Bool {
        let biometricAuthenticationIsEnabled: Bool = UserDefaults.standard.bool(forKey: "BiometricAuthenticationIsEnabled")
        print(biometricAuthenticationIsEnabled)
        return biometricAuthenticationIsEnabled
    }
    
    func authenticateBiometric() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Use biometrics to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    }
                }
            }
        }
    }
}
