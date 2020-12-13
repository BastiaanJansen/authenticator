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
    var issuer: String
    var name: String
    var secret: String
    
    var digits: Int
    var timeInterval: Int
    var algorithm: Algorithm
    
    init(issuer: String, name: String, secret: String, digits: Int = 6, timeInterval: Int = 30, algorithm: Algorithm = .sha1) {
        self.id = UUID()
        self.issuer = issuer
        self.name = name
        self.secret = secret
        self.digits = digits
        self.timeInterval = timeInterval
        self.algorithm = algorithm
    }
    
    func generateCode() -> String? {
        let generator: CodeGenerator = CodeGenerator(digits: digits, timeInterval: timeInterval, algorithm: algorithm)
        return generator.generate(forSecret: self.secret)
    }
    
    func calculateSecondsUntilRefresh() -> Int {
        return timeInterval - Int(floor(Date().timeIntervalSince1970)) % timeInterval
    }
}

extension Account {
    convenience init(from url: URL) throws {
        let queryItems = url.queryDictionary
        
        guard let scheme = url.scheme, scheme == "otpauth" else { throw AccountError.invalidURL }
        
        guard let host = url.host, host == GeneratorAlgorithm.totp.rawValue else {
            throw AccountError.invalidURL
        }
        
        let splitName = url.path.dropFirst().split(separator: ":")
        let name: String? = splitName.last?.trimmingCharacters(in: .whitespacesAndNewlines)
        let issuer: String? = splitName.count > 1 ? splitName.first!.trimmingCharacters(in: .whitespacesAndNewlines) : nil
        
        guard let secret = queryItems?[AccountKey.secret.rawValue] else {
            throw AccountError.invalidURL
        }
        
        var digits = 6
        if let digitsString = queryItems?[AccountKey.digits.rawValue] {
            let digitsInt = Int(digitsString) ?? digits
            guard 6...8 ~= digitsInt else {
                throw AccountError.invalidURL
            }
            digits = digitsInt
        }
        
        var period = 30
        if let periodString = queryItems?[AccountKey.period.rawValue] {
            period = Int(periodString) ?? period
        }
        
        var algorithm = Algorithm.sha1
        if let algorithmString = queryItems?[AccountKey.algorithm.rawValue] {
            algorithm = Algorithm(rawValue: algorithmString) ?? algorithm
        }
        
        self.init(issuer: issuer ?? "", name: name ?? "", secret: secret, digits: digits, timeInterval: period, algorithm: algorithm)
    }
}

enum GeneratorAlgorithm: String {
    case totp
}

enum AccountKey: String, CodingKey {
    case
    issuer,
    name,
    secret,
    digits,
    algorithm,
    period
}

enum AccountError: Error {
    case invalidURL, invalidSecret, invalidIssuer, invalidName
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
