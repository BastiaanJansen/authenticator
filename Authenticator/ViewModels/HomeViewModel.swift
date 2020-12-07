//
//  HomeViewModel.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import SwiftOTP
import CoreData

class HomeViewModel: ObservableObject {
    var context: NSManagedObjectContext?

    @Published var showSettingsView: Bool = false
    @Published var showScanQRCodeView: Bool = false
    
    func delete(account: Account) {
        guard let context = self.context else { fatalError("Context is not set") }
        context.delete(account)
        context.saveContext()
    }
}
