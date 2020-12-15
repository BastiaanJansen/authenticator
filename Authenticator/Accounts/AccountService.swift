//
//  AccountService.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 13/12/2020.
//

import Foundation
import SwiftKeychainWrapper
import Combine

class AccountService {
    public static let shared = AccountService()
    
    public let publisher = CurrentValueSubject<Array<Account>, Never>([])
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let keychainInstance = KeychainWrapper(serviceName: KeychainWrapper.serviceName, accessGroup: KeychainWrapper.accessGroup)
    
    init() {
        publisher.send(get())
    }
    
    func get() -> [Account] {
        let data = keychainInstance.data(forKey: .accounts)

        guard (data != nil) else { return [] }
        
        do {
            let accounts = try decoder.decode(Array<Account>.self, from: data!)
            
            publisher.send(accounts)
            
            return accounts
        } catch {
            print("Something went wrong decoding: \(error)")
        }
        
        return []
    }
    
    @discardableResult
    func save(from account: Account) -> Bool {
        var accounts: [Account] = get()
    
        accounts.append(account)
        
        do {
            let data = try encoder.encode(accounts)
            publisher.send(accounts)
            return keychainInstance.set(data, forKey: KeychainWrapper.Key.accounts.rawValue)
        } catch {
            print("Something went wrong encoding: \(error)")
        }
        
        return false
    }
    
    @discardableResult
    func delete(account: Account) -> Bool {
        var accounts = get()
        
        let index = accounts.firstIndex(where: { (accountInArray) -> Bool in
            accountInArray.id == account.id
        })
        
        if let index = index {
            accounts.remove(at: index)
            
            return save(for: accounts)
        }
        
        return false
    }
    
    @discardableResult
    func delete() -> Bool {
        return save(for: [])
    }
    
    @discardableResult
    private func save(for accounts: [Account]) -> Bool {
        do {
            let data = try encoder.encode(accounts)
            
            let isSuccess = keychainInstance.set(data, forKey: KeychainWrapper.Key.accounts.rawValue)
            
            publisher.send(accounts)
            
            return isSuccess
        } catch {
            print("Something went wrong encoding: \(error)")
        }
        
        return false
    }
}
