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
    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    private var shouldDismissView = false {
        didSet {
            viewDismissalModePublisher.send(shouldDismissView)
        }
    }
    
    @Published var showAddAccountView: Bool = false
    
    func foundBarcode(value: String) {
        var map: [String: String] = [:]
        let info = value.split(separator: "/")[2]
        
        let paramInfo = info.split(separator: "?")
        let name = paramInfo[0].split(separator: ":")[1]
        map["name"] = String(name)
        
        let params = paramInfo[1].split(separator: "&")
        
        params.forEach { param in
            let pair = param.split(separator: "=")
            map[String(pair[0])] = String(pair[1])
        }
        
        let _ = self.createAccount(service: map["issuer"]!, name: map["name"]!, key: map["secret"]!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("sds")
            self.shouldDismissView = true
        }
        
    }
    
    func createAccount(service: String, name: String, key: String) -> Account {
        guard let context = self.context else { fatalError("Context is not set") }
        let account = Account(context: context, service: service, name: name, key: key)
        
        context.saveContext()
        
        return account
    }
}
