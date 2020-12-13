//
//  AccountRow.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI

struct AccountRow: View {
    @ObservedObject var account: Account
    @State var secondsUntilRefresh = 0
    @State var code: String?
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(account.issuer).bold()
                Text(account.name).foregroundColor(.gray).font(.system(size: 14))
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(code?.separate(every: 3, with: " ") ?? "No code")
                    .font(.title2)
                    .bold()
                Text(String(secondsUntilRefresh))
                    .bold()
                    .if(secondsUntilRefresh > 5) {
                        $0.foregroundColor(.accentColor)
                    }
                    .if(secondsUntilRefresh <= 5) {
                        $0.foregroundColor(.red)
                    }
            }
        }
        .onAppear {
            self.code = account.generateCode()
        }
        .padding(.top, 5)
        .padding(.bottom, 5)
        .onReceive(timer, perform: { _ in
            let remainder = account.calculateSecondsUntilRefresh()
            self.secondsUntilRefresh = remainder
    
            if remainder == account.timeInterval {
                self.code = account.generateCode()
                self.secondsUntilRefresh = account.timeInterval
            }
        })
    }
}

struct AccountRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let account = Account.init(issuer: "Test service", name: "email@mail.com", secret: "DREERRRR")
        return AccountRow(account: account).environment(\.managedObjectContext, context)
    }
}
