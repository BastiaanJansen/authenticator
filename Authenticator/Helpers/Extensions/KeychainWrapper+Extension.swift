//
//  KeychainWrapper+Extension.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 15/12/2020.
//

import Foundation
import SwiftKeychainWrapper

extension KeychainWrapper.Key {
    static let accounts: KeychainWrapper.Key = "accounts"
}

extension KeychainWrapper {
    static let serviceName = "accounts"
    static let accessGroup = "group.dev.basjansen.Authenticator"
}
