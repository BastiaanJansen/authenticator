//
//  SettingsViewModel.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI
import SwiftKeychainWrapper
import LocalAuthentication

class SettingsViewModel: ObservableObject {
    @Published var biometricAuthenticationIsEnabled: Bool {
        didSet {
            UserDefaults.biometricAuthenticationIsEnabled = biometricAuthenticationIsEnabled
        }
    }
    
    @Published var autoLockIsEnabled: Bool {
        didSet {
            UserDefaults.autoLockIsEnabled = autoLockIsEnabled
        }
    }
    
    @Published var widgetsAreEnabled: Bool {
        didSet {
            UserDefaults.widgetsAreEnabled = widgetsAreEnabled
        }
    }
    
    @Published var appleWatchIsEnabled: Bool {
        didSet {
            
        }
    }
    
    init() {
        self.biometricAuthenticationIsEnabled = UserDefaults.biometricAuthenticationIsEnabled
        self.autoLockIsEnabled = UserDefaults.autoLockIsEnabled
        self.widgetsAreEnabled = UserDefaults.widgetsAreEnabled
        self.appleWatchIsEnabled = false
    }
    
    func getAppVersion() -> String? {
        guard let infoDictionary = Bundle.main.infoDictionary else { return nil }
        if let version = infoDictionary["CFBundleShortVersionString"] as? String, let build = infoDictionary["CFBundleVersion"] as? String {
            return "\(version) (\(build))"
        }
        
        return nil
    }
}
