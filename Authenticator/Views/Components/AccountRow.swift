//
//  AccountRow.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI

struct AccountRow: View {
    @ObservedObject var account: Account
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(account.service).bold()
                Text(account.name).foregroundColor(.gray).font(.system(size: 14))
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(account.code ?? "No code").font(.title2).bold()
                Text(String(account.secondsUntilRefresh)).foregroundColor(.accentColor).bold()
            }
        }
        .padding(.top, 5)
        .padding(.bottom, 5)
        .onReceive(timer, perform: { date in
            self.account.update()
        })
    }
}

struct AccountRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let account = Account.init(context: context, service: "Test service", name: "email@mail.com", key: "DREERRRR")
        return AccountRow(account: account).environment(\.managedObjectContext, context)
    }
}
