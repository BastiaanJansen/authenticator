//
//  UserDefaultsExtension.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 08/12/2020.
//

import SwiftUI

extension UserDefaults {
    func valueExists(forKey key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}

extension UserDefaults {
    public enum Key: String {
        case biometricAuthenticationIsEnabled = "BiometricAuthenticationIsEnabled"
        case widgetsAreEnabled = "WidgetsAreEnabled"
        case autoLockIsEnabled = "AutoLockIsEnabled"
        case colorScheme = "ColorScheme"
    }
    
    class var biometricAuthenticationIsEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Key.biometricAuthenticationIsEnabled.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.biometricAuthenticationIsEnabled.rawValue)
        }
    }
    
    class var widgetsAreEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Key.widgetsAreEnabled.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.widgetsAreEnabled.rawValue)
        }
    }
    
    class var autoLockIsEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Key.autoLockIsEnabled.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.autoLockIsEnabled.rawValue)
        }
    }
}

extension UserDefaults {
    func set(default value: Any, for key: Key) {
        let rawVavlueOfKey = key.rawValue
        UserDefaults.standard.register(defaults: [
            rawVavlueOfKey: value
        ])
    }
    
    func set(defaultValues: [Key: Any]) {
        for defaultValue in defaultValues {
            self.set(default: defaultValue.value, for: defaultValue.key)
        }
    }
}
