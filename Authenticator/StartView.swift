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
            Button(action: {
                startVM.authenticateBiometric()
            }) {
                HStack {
                    Image(systemName: BiometricAuthService.shared.biometricType == .faceID ? "faceid" : "touchid")
                    Text("Unlock")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
