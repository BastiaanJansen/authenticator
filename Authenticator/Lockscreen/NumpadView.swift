//
//  Numpad.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 09/12/2020.
//

import SwiftUI

struct NumpadView: View {
    var maxCodeLength: Int = 6
    var biometricButton: Bool = true
    var onSubmit: () -> Bool
    var onBiometricAuthentication: () -> Void
    
    @State var code: [Int] = []
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                ForEach(0..<maxCodeLength) { index in
                    if indexExists(index) {
                        DotView(filled: true)
                    } else {
                        DotView()
                    }
                }
            }
            
            Spacer().frame(height: 40)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 30) {
                Group {
                    ForEach(1..<10) { number in
                        PasscodeButtonView(
                            content: Text(String(number)).passcodeButtonNumber(),
                            onClick: {addToCode(number: number)}
                        )
                    }
                }
                Group {
                    PasscodeButtonView(
                        background: false,
                        content: Image(systemName: AuthenticatorApp.biometricType() == .faceID ? "faceid" : "touchid").imageScale(.large).foregroundColor(AuthenticatorApp.biometricType() == .faceID ? .green : .red),
                        onClick: onBiometricAuthentication
                    )
                    PasscodeButtonView(
                        content: Text("0").passcodeButtonNumber(),
                        onClick: {addToCode(number: 0)}
                    )
                    PasscodeButtonView(
                        background: false,
                        content: Image(systemName: "delete.left").foregroundColor(.red),
                        onClick: removeLastFromCode
                    )
                }
            }.padding()
        }
    }
    
    func addToCode(number: Int) {
        if code.count < maxCodeLength {
            code.append(number)
        }
        
        if code.count == maxCodeLength {
            let result = onSubmit()
            if !result {
                code.removeAll()
            }
        }
    }
    
    func removeLastFromCode() {
        if !code.isEmpty {
            code.removeLast()
        }
    }
    
    func indexExists(_ index: Int) -> Bool {
        return code.indices.contains(index)
    }
}

struct Numpad_Previews: PreviewProvider {
    static var previews: some View {
        NumpadView(onSubmit: {
            return true
        }, onBiometricAuthentication: {
            print("Biometric authentication")
        })
    }
}
