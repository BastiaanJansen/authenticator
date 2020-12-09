//
//  PasscodeViewModel.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 09/12/2020.
//

import Foundation

class PasscodeViewModel: ObservableObject {
    
    func validateCode() -> Bool {
        print("Validating code...")
        return false
    }
    
    func biometricAuthentication() {
        print("Biometric authentication...")
    }
}
