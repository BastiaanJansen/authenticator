//
//  ScanQRCodeViewModel.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import CoreData
import Combine

class ScanQRCodeViewModel: ObservableObject {
    var context: NSManagedObjectContext?
    
    @Published var accountCreated: Bool = false
    @Published var showAddAccountView: Bool = false

    
    func foundBarcode(url: URL) {
        var map: [String: String] = [:]
        let mustHaveKeys = ["issuer", "secret", "period"]
        
        guard url.scheme == "otpauth" else { return }
       
        guard url.host == "totp" else { return }
        
        guard let query = url.query else { return }
        
        let path = url.path
        
        let name = path.split(separator: ":")
        
        if name.count == 1 {
            map["name"] = String(name[0])
        } else {
            map["name"] = String(name[1])
        }
        
        let params = query.split(separator: "&")
        
        params.forEach { param in
            let splitted = param.split(separator: "=")
            let key = String(splitted[0])
            let value = String(splitted[1])
            map[key] = value
        }
        
        guard self.has(mustHaveKeys: mustHaveKeys, in: map) else { return }
        let _ = self.createAccount(service: map["issuer"]!, name: map["name"]!, key: map["secret"]!)
        
    }
    
    private func has(mustHaveKeys keys: [String], in dictionary: [String: String]) -> Bool {
        for key in keys {
            if dictionary[key] == nil { return false }
        }
        
        return true
    }
    
    func createAccount(service: String, name: String, key: String) -> Account {
        guard let context = self.context else { fatalError("Context is not set") }
        let account = Account(service: service, name: name, key: key)
        
        context.saveContext()
        
        self.accountCreated = true
        
        return account
    }
}
