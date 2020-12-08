//
//  AppIconService.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 08/12/2020.
//

import UIKit

class AppIconService {
    enum AppIcon: String, CaseIterable {
        case indigo = "IndigoIcon"
        case black = "BlackIcon"
        case darkPlum = "DarkPlumIcon"
    }
    
    static func changeIcon(to icon: AppIcon) {
        let name: String? = icon == .indigo ? nil : icon.rawValue
        
        UIApplication.shared.setAlternateIconName(name, completionHandler: { error in
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
}
