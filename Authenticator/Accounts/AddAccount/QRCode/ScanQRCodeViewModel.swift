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
    
    @Published var account: Account?
    @Published var showAddAccountView: Bool = false
    
    init() {
//        let url = URL(string: "otpauth://totp/Example.com:alice@example.com?algorithm=SHA1&digits=6&issuer=Example.com&period=30&secret=K3XT7VEUS7JFJVCX")
//        foundBarcode(url: url!)
    }

    
    func foundBarcode(value: String) {
        guard let url = URL(string: value) else { return }
        
        do {
            let account = try Account.init(from: url)
            self.account = account
        } catch {
            print("Something went wrong \(error)")
        }
    }
}
