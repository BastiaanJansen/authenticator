//
//  SettingsViewModel.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI
import SwiftKeychainWrapper
import Combine

class SettingsViewModel: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()
    
    @Published var biometricAuthenticationIsEnabled: Bool {
        didSet {
            if !biometricAuthenticationIsEnabled {
                let authService = BiometricAuthService(reason: "Unlock to change setting")
                authService.authenticate { [self] (success, error) in
                    if !success {
                        DispatchQueue.main.async {
                            biometricAuthenticationIsEnabled = oldValue
                        }
                    }
                }
            }
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
    
    private func update() {
        didChange.send(())
    }
}
