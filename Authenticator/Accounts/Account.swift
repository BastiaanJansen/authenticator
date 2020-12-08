//
//  Account.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import SwiftOTP
import CoreData

class Account: NSManagedObject, Identifiable {
    @NSManaged private(set) var id: UUID
    @NSManaged private(set) var service: String
    @NSManaged private(set) var name: String
    @NSManaged private(set) var key: String
    private var generator: CodeGenerator = CodeGenerator()
    
    @Published var secondsUntilRefresh: Int = 0
    @Published var code: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.setCode()
        self.update()
    }
    
    convenience init(context: NSManagedObjectContext, service: String, name: String, key: String) {
        self.init(context: context)
        
        self.id = UUID()
        self.service = service
        self.name = name
        self.key = key
        
        self.setCode()
    }
}

extension Account {
    func update() {
        objectWillChange.send()
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
