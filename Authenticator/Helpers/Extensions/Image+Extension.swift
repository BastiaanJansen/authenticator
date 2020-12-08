//
//  Image+Extension.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 08/12/2020.
//

import SwiftUI

extension Image {
    enum IconName: String {
        case indigo
        case black
        case ripePlum
    }
    
    init(iconName: IconName) {
        self.init(decorative: iconName.rawValue)
    }
}
