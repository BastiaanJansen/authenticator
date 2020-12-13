//
//  BiometricAuthService.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 12/12/2020.
//

import Foundation
import LocalAuthentication

class BiometricAuthService: AuthService {
    
    public static let shared = BiometricAuthService()
    private let reason = "Unlock your device with biometrics"
    private let context = LAContext()
    private var error: NSError?
    
    enum BiometricType {
        case none
        case touchID
        case faceID
    }
    
    var biometricType: BiometricType {
        guard self.context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            return .none
        }

        if #available(iOS 11.0, *) {
            switch context.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            @unknown default:
                return .none
            }
        } else {
            return self.context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) ? .touchID : .none
        }
    }
    
    func authenticate(completion: @escaping (Bool, Error?) -> Void) {
        if self.biometricType == .none {
            return completion(false, BiometricAuthenticationError.notAvailable)
        }
        
        self.context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: self.reason, reply: completion)
    }
}

enum BiometricAuthenticationError: Error {
    case notAvailable
 }
