//
//  DotView.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 09/12/2020.
//

import SwiftUI

struct DotView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var filled: Bool = false
    
    var body: some View {
        Circle()
            .strokeBorder(colorScheme == .light ? Color.black : Color.white, lineWidth: 1.5).if(filled) {
                $0.background(Circle().foregroundColor(colorScheme == .light ? .black : .white))
            }
            .frame(width: 12, height: 12)
    }
}
