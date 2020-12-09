//
//  IfViewModifier.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 09/12/2020.
//

import SwiftUI

extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
         if conditional {
             return AnyView(content(self))
         } else {
             return AnyView(self)
         }
     }
}
