//
//  AuthService.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 09/12/2020.
//

import Foundation
import LocalAuthentication
import SwiftKeychainWrapper

class PasscodeAuthService: AuthService {
    func authenticate(completion: (Bool, Error?) -> Void) {
        return completion(false, nil)
    }
}
