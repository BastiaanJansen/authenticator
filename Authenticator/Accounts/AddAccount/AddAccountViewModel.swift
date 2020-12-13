//
//  AddAccountViewModel.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import CoreData
import SwiftKeychainWrapper
import SwiftOTP

class AddAccountViewModel: ObservableObject {
    @Published var service: String
    @Published var name: String
    @Published var key: String
    
    @Published var showAdvancedOptions: Bool
    @Published var algorithm: Algorithm
    @Published var digits: Digit
    @Published var interval: Int
    
    init(service: String = "", name: String = "", key: String = "", algorithm: Algorithm = .sha1, digits: Digit = .six, interval: Int = 30) {
        self.service = service
        self.name = name
        self.key = key
        self.showAdvancedOptions = false
        self.algorithm = algorithm
        self.digits = digits
        self.interval = interval
    }
    
    func add() {
        let account = Account(service: self.service, name: self.name, key: self.key, digits: self.digits.rawValue, timeInterval: self.interval, algorithm: self.algorithm)
        
        AccountService.shared.save(from: account)
    }
}
