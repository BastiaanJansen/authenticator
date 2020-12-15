//
//  AccountRow.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 06/12/2020.
//

import SwiftUI
import WidgetKit

struct AccountRow: View {
    @ObservedObject var account: Account
    @State var secondsUntilRefresh = 0
    @State var code: String?
    
    @State var progress: Float = 0.0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(account.issuer)
                        .bold()
                        .font(.system(size: 23))
                    Text(account.name).foregroundColor(.gray).font(.system(size: 14))
                }
                
                Spacer()
                
                VStack {
                    CircularProgressBar(progress: .constant(progress), color: secondsUntilRefresh <= 5 ? .constant(.red) : .constant(.accentColor))
                        .frame(width: 23, height: 23)
                }
            }
            
            Spacer().frame(height: 20)
            
            HStack {
                ForEach(Array(Array(code ?? "").enumerated()), id: \.offset) { index, character in
                    Text(String(character))
                        .bold()
                        .foregroundColor(.accentColor)
                        .font(.system(size: 17))
                        .frame(width: 35, height: 35)
                        .background(
                            Color.accentColor.opacity(0.15)
                        )
                        .cornerRadius(10)
                        .clipShape(Rectangle())
                    
                    if let code = code {
                        if index == code.count / 2 - 1 {
                            Spacer().frame(width: 20)
                        }
                    }
                }
            }
            
        }
        .padding(.vertical)
        .onAppear {
            code = account.generateCode()
            secondsUntilRefresh = account.calculateSecondsUntilRefresh()
            progress = 1 - Float(secondsUntilRefresh) / Float(account.timeInterval)
        }
        .onReceive(timer, perform: { _ in
            let remainder = account.calculateSecondsUntilRefresh()
            secondsUntilRefresh = remainder
            progress = 1 - Float(secondsUntilRefresh) / Float(account.timeInterval)
    
            if remainder == account.timeInterval {
                self.code = account.generateCode()
                self.secondsUntilRefresh = account.timeInterval
                WidgetCenter.shared.reloadAllTimelines()
            }
        })
    }
}

struct AccountRow_Previews: PreviewProvider {
    static var previews: some View {
        let account = Account.init(issuer: "Test service", name: "email@mail.com", secret: "DREERRRR")
        return AccountRow(account: account)
    }
}
