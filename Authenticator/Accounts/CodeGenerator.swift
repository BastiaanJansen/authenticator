//
//  CodeGenerator.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import SwiftOTP

class CodeGenerator {
    private(set) var digits: Int
    private(set) var timeInterval: Int
    private(set) var algorithm: OTPAlgorithm
    
    init(digits: Int = 6, timeInterval: Int = 30, algorithm: OTPAlgorithm = .sha1) {
        self.digits = digits
        self.timeInterval = timeInterval
        self.algorithm = algorithm
    }
    
    func generate(key: String) -> String? {
        guard let data = base32DecodeToData(key) else { return nil }
        
        guard let totp = TOTP(secret: data, digits: self.digits, timeInterval: self.timeInterval, algorithm: self.algorithm) else { return nil }
        
        guard let code: String = totp.generate(time: Date()) else { return nil }
        
        return code
    }
}
