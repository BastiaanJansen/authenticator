//
//  HomeViewModel.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import Foundation
import SwiftOTP

class HomeViewModel: ObservableObject {
    
    init() {
        guard let data = base32DecodeToData("DREERRRR") else { return }
        
        if let totp = TOTP(secret: data, digits: 6, timeInterval: 30, algorithm: .sha1) {
            let code: String? = totp.generate(time: Date())
            
            print(code ?? "No code")
        }
    }
}
