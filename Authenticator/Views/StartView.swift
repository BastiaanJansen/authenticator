//
//  ContentView.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI

struct StartView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var startVM = StartViewModel()

    var body: some View {
        if startVM.isUnlocked {
            HomeView()
        } else {
//            Button(action: {
//                startVM.authenticateBiometric()
//            }) {
//                HStack {
//                    Image(systemName: AuthenticatorApp.biometricType() == BiometricType.faceID ? "faceid" : "touchid")
//                    Text("Unlock")
//                }
//            }
            Text("Not unlocked")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
