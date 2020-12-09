//
//  PasscodeView.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 09/12/2020.
//

import SwiftUI

struct PasscodeView: View {
    @ObservedObject var passcodeVM = PasscodeViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 10) {
                Text("Enter Passcode").bold()
                Text("Welcome back, please enter your passcode to enter the application.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .padding(.vertical, 30)
            
            Spacer().frame(height: 20)
            
            NumpadView(
                onSubmit: passcodeVM.validateCode,
                onBiometricAuthentication: passcodeVM.biometricAuthentication
            )
            
            Spacer()
        }.padding(.horizontal, 30)
    }
}

struct PasscodeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PasscodeView()
            PasscodeView().preferredColorScheme(.dark)
        }
    }
}
