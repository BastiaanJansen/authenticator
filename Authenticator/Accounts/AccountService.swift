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
    
    init() {
        publisher.send(getAll() ?? [])
    }
    
    func getAll() -> [Account]? {
        let data = KeychainWrapper.standard.data(forKey: "accounts")

        guard (data != nil) else { return [] }
        
        do {
            let accounts = try decoder.decode(Array<Account>.self, from: data!)
            
            publisher.send(accounts)
            
            return accounts
        } catch {
            print("Something went wrong decoding: \(error)")
        }
        
        return nil
    }
    
    @discardableResult
    func save(from account: Account) -> Bool {
        let accounts = getAll()
        
        if var accounts = accounts {
            accounts.append(account)
            
            do {
                let data = try encoder.encode(accounts)
                
                publisher.send(accounts)
                
                return KeychainWrapper.standard.set(data, forKey: "accounts")
            } catch {
                print("Something went wrong encoding: \(error)")
            }
        }
        
        return false
    }
    
    func save(from url: URL) {
        
    }
    
    func delete(account: Account) {
        let accounts = getAll()
        
        let index = accounts?.firstIndex(where: { (accountInArray) -> Bool in
            accountInArray.id == account.id
        })
        
        if let index = index, var accounts = accounts {
            accounts.remove(at: index)
            
            save(accounts: accounts)
            
            publisher.send(accounts)
        }
    }
    
    @discardableResult
    private func save(accounts: [Account]) -> Bool {
        do {
            let data = try encoder.encode(accounts)
            
            return KeychainWrapper.standard.set(data, forKey: "accounts")
        } catch {
            print("Something went wrong encoding: \(error)")
        }
        
        return false
    }
}
