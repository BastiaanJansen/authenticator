//
//  CodeGenerator.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import SwiftOTP

class CodeGenerator {
    public static let shared = CodeGenerator()
    private(set) var digits: Int
    private(set) var timeInterval: Int
    private(set) var algorithm: OTPAlgorithm
    
    init(digits: Int = 6, timeInterval: Int = 30, algorithm: Algorithm = .sha1) {
        self.digits = digits
        self.timeInterval = timeInterval
        
        switch algorithm {
        case .sha1:
            self.algorithm = OTPAlgorithm.sha1
            break
        case .sha256:
            self.algorithm = OTPAlgorithm.sha256
            break
        case .sha512:
            self.algorithm = OTPAlgorithm.sha512
            break
        }
    }
    
    func generate(forKey: String) -> String? {
        guard let data = base32DecodeToData(forKey) else { return nil }
        
        guard let totp = TOTP(secret: data, digits: self.digits, timeInterval: self.timeInterval, algorithm: self.algorithm) else { return nil }
        
        guard let code: String = totp.generate(time: Date()) else { return nil }
        
        return code
    }
}
