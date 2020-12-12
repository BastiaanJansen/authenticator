//
//  View+Extension.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 12/12/2020.
//

import SwiftUI
import UIKit

extension View {
    func hideKeyboard() -> Void {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
