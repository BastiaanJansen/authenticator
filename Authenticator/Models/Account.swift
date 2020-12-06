//
//  Account.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import SwiftOTP

class Account: ObservableObject, Identifiable {
    let id: UUID
    let service: String
    let name: String
    let key: String
    let generator: CodeGenerator
    
    @Published var secondsUntilRefresh: Int
    @Published var code: String?
    
    
    init(service: String, name: String, key: String, generator: CodeGenerator = CodeGenerator()) {
        self.id = UUID()
        self.service = service
        self.name = name
        self.key = key
        self.generator = generator
        self.secondsUntilRefresh = 0
        self.secondsUntilRefresh = self.calculateSecondsUntilRefresh()
        
        self.setCode()
    }
    
    func update() {
        let remainder = self.calculateSecondsUntilRefresh()
        self.secondsUntilRefresh = remainder
        
        if remainder == self.generator.timeInterval {
            self.setCode()
            self.secondsUntilRefresh = self.generator.timeInterval
        }
    }
    
    private func calculateSecondsUntilRefresh() -> Int {
        return generator.timeInterval - Int(floor(Date().timeIntervalSince1970)) % generator.timeInterval
    }
    
    
    private func setCode() {
        let code: String? = self.generator.generate(key: self.key)
        self.code = code?.separate(every: 3, with: " ") ?? code
    }
}
