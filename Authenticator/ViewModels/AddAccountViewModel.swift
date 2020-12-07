//
//  AddAccountViewModel.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import CoreData
import SwiftKeychainWrapper

class AddAccountViewModel: ObservableObject {
    var context: NSManagedObjectContext?
    
    @Published var service: String
    @Published var name: String
    @Published var key: String
    
    init(service: String = "", name: String = "", key: String = "") {
        self.service = service
        self.name = name
        self.key = key
    }
    
    func add() {
        guard let context = self.context else { fatalError("Context is not set") }
        
        let _ = Account(context: context, service: self.service, name: self.name, key: self.key)
        
        context.saveContext()
    }
}
