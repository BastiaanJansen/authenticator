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
    let publisher = PassthroughSubject<Account, Never>();
    var cancellable: AnyCancellable?
    
    @Published var account: Account?
    @Published var showAddAccountView: Bool = false
    var addAccountVM: AddAccountViewModel?

    func foundBarcode(value: String) {
        guard let url = URL(string: value) else { return }
        
        do {
            let account = try Account(from: url)
            self.account = account
            publisher.send(account)
        } catch {
            print("Something went wrong \(error)")
        }
    }
}
