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
    var context: NSManagedObjectContext?
    
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
        guard let context = self.context else { fatalError("Context is not set") }
        
        let _ = Account(context: context, service: self.service, name: self.name, key: self.key)
        
        context.saveContext()
    }
}

enum Algorithm: String, CaseIterable {
    case sha1 = "SHA1"
    case sha256 = "SHA256"
    case sha512 = "SHA512"
}

enum Digit: Int, CaseIterable {
    case six = 6
    case eight = 8
}
