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
    @Published var issuer: String
    @Published var name: String
    @Published var secret: String
    
    @Published var showAdvancedOptions: Bool
    @Published var algorithm: Algorithm
    @Published var digits: Int
    @Published var timeInterval: Int
    
    init(issuer: String = "", name: String = "", secret: String = "", algorithm: Algorithm = .sha1, digits: Int = 6, timeInterval: Int = 30) {
        self.issuer = issuer
        self.name = name
        self.secret = secret
        self.showAdvancedOptions = false
        self.algorithm = algorithm
        self.digits = digits
        self.timeInterval = timeInterval
    }
    
    convenience init(account: Account) {
        self.init(issuer: account.issuer, name: account.name, secret: account.secret, algorithm: account.algorithm, digits: account.digits, timeInterval: account.timeInterval)
    }
    
    func add() {
        let account = Account(issuer: self.issuer, name: self.name, secret: self.secret, digits: self.digits, timeInterval: self.timeInterval, algorithm: self.algorithm)
        
        AccountService.shared.save(from: account)
    }
}
