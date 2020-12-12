//
//  BiometricAuthService.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 12/12/2020.
//

import Foundation
import LocalAuthentication

class BiometricAuthService: AuthService {
    
    let reason: String
    let context: LAContext
    
    init(reason: String) {
        self.reason = reason
        self.context = LAContext()
    }
    
    func authenticate(completion: @escaping (Bool, Error?) -> Void) {
        
        if !BiometricAuthService.isAvailable() {
            completion(false, BiometricAuthenticationError.notAvailable)
        }
        
        self.context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: self.reason, reply: completion)
    }
    
    static func isAvailable() -> Bool {
        let authContext = LAContext()
        var error: NSError?
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            return true
        }
        
        return false
    }
    
    static func getType() -> BiometricType {
        let context = LAContext()
        
        guard BiometricAuthService.isAvailable() else { return .none }
        
        switch(context.biometryType) {
        case .none:
            return BiometricType.none
        case .touchID:
            return BiometricType.touchID
        case .faceID:
            return BiometricType.faceID
        @unknown default:
            return BiometricType.none
        }
    }
}

enum BiometricAuthenticationError: Error {
    case notAvailable
 }

enum BiometricType {
    case none
    case touchID
    case faceID
}
