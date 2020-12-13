//
//  HomeViewModel.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import SwiftOTP
import CoreData
import Combine

class HomeViewModel: ObservableObject {
    var cancellable: AnyCancellable?
    
    @Published var accounts: [Account] = []

    @Published var showSettingsView: Bool = false
    @Published var showScanQRCodeView: Bool = false
    
    init() {
        accounts = AccountService.shared.publisher.value
        
        cancellable = AccountService.shared.publisher.sink { accounts in
            self.accounts = accounts
        }
    }
    
    func delete(account: Account) {
        AccountService.shared.delete(account: account)
    }
}
