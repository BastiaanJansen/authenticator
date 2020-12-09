//
//  PasscodeButtonView.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 09/12/2020.
//

import SwiftUI
import Combine

struct PasscodeButtonView<Content: View>: View {
    var background: Bool = true
    let content: Content
    var onClick: () -> Void = {}
    
    var body: some View {
        Button(action: {
            onClick()
        }) {
            ZStack(alignment: .center) {
                Circle()
                    .foregroundColor(Color.secondary.opacity(background ? 0.15 : 0))
                    .frame(width: 80, height: 80)
                content
            }
        }
    }
}

extension Text {
    func passcodeButtonNumber() -> Text {
        self
            .font(.title)
            .bold()
            .foregroundColor(.accentColor)
    }
}

struct PasscodeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PasscodeButtonView(content: Text("1").passcodeButtonNumber())
            PasscodeButtonView(content: Text("1").passcodeButtonNumber())
                .preferredColorScheme(.dark)
        }
    }
}
