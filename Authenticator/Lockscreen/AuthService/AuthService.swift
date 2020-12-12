//
//  AuthService.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 12/12/2020.
//

import Foundation

protocol AuthService {
    func authenticate(completion: @escaping (_ success: Bool, _ error: Error?) -> Void)
}
