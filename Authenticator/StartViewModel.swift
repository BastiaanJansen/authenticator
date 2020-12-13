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
        return UserDefaults.biometricAuthenticationIsEnabled
    }
    
    func authenticateBiometric() {
        BiometricAuthService.shared.authenticate { (success, error) in
            DispatchQueue.main.async {
                if success {
                    return self.isUnlocked = true
                }
                
                if let error = error {
                    print(error)
                }
            }
        }
    }
}
