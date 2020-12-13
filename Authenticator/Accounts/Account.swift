//
//  Account.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import SwiftOTP
import CoreData

class Account: ObservableObject, Codable, Identifiable {
    var id: UUID
    var service: String
    var name: String
    var key: String
    
    var digits: Int
    var timeInterval: Int
    var algorithm: Algorithm
    
    init(service: String, name: String, key: String, digits: Int = 6, timeInterval: Int = 30, algorithm: Algorithm = .sha1) {
        self.id = UUID()
        self.service = service
        self.name = name
        self.key = key
        self.digits = digits
        self.timeInterval = timeInterval
        self.algorithm = algorithm
    }
    
    func generateCode() -> String? {
        let generator: CodeGenerator = CodeGenerator(digits: digits, timeInterval: timeInterval, algorithm: algorithm)
        return generator.generate(forKey: self.key)
    }
    
    func calculateSecondsUntilRefresh() -> Int {
        return timeInterval - Int(floor(Date().timeIntervalSince1970)) % timeInterval
    }
}

enum Algorithm: String, CaseIterable, Codable {
    case sha1 = "SHA1"
    case sha256 = "SHA256"
    case sha512 = "SHA512"
}

enum Digit: Int, CaseIterable {
    case six = 6
    case eight = 8
}
