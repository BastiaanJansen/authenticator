//
//  HomeViewModel.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import SwiftOTP

class HomeViewModel: ObservableObject {
    
    @Published var accounts: [Account] = [
        Account(service: "Microsoft", name: "myemail@mail.com", key: "DREERRRR"),
        Account(service: "Google", name: "myemail@mail.com", key: "DREERRRRSD")
    ]
    @Published var showScanQRCodeView: Bool = false
    
//    init() {
//        guard let data = base32DecodeToData("DREERRRR") else { return }
//        
//        if let totp = TOTP(secret: data, digits: 6, timeInterval: 30, algorithm: .sha1) {
//            let code: String? = totp.generate(time: Date())
//            
//            print(code ?? "No code")
//        }
//    }
}
