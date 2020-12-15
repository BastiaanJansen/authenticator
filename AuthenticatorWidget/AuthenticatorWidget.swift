//
//  AuthenticatorWidget.swift
//  AuthenticatorWidget
//
//  Created by Bastiaan Jansen on 15/12/2020.
//

import WidgetKit
import SwiftUI
import Intents
import SwiftKeychainWrapper
import SwiftOTP

struct AccountEntry: TimelineEntry {
    var date: Date
    var accounts: [Account]
    
}

struct Provider: TimelineProvider {
    let homeVM = HomeViewModel()
    
    func placeholder(in context: Context) -> AccountEntry {
        let accounts = AccountService.shared.get()
        return AccountEntry(date: Date(), accounts: accounts)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (AccountEntry) -> Void) {
        let accounts = AccountService.shared.get()
        let entry = AccountEntry(date: Date(), accounts: accounts)
        print("Getting snapshot")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<AccountEntry>) -> Void) {
        
//        let accounts = [
//            Account(issuer: "Microsoft", name: "email@mail.com", secret: "DREERRRR", digits: 6, timeInterval: 30, algorithm: .sha1)
//        ]
        
        print("Getting timeline")
        
        let accounts = AccountService.shared.get()
        
        let entryDate = Calendar.current.date(byAdding: .second, value: 30, to: Date())!
        let entry = AccountEntry(date: entryDate, accounts: accounts)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        
        completion(timeline)
    }
    
    
}

struct AuthenticatorWidgetEntryView: View {
    @Environment(\.widgetFamily) var size
    
    let entry: Provider.Entry
    
    var body: some View {
        switch size {
        case .systemSmall: Text("Not supported")
        case .systemMedium: AuthenticatorWidgetMediumView(entry: entry)
        case .systemLarge: AuthenticatorWidgetLargeView(entry: entry)
        @unknown default:
            Text("Not supported")
        }
    }
    
}

struct AuthenticatorWidgetMediumView: View {
    let entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading) {
//            ForEach(entry.accounts, id: \.id) { account in
//                AccountRow(account: account)
//            }
            if entry.accounts.count > 0 {
                AccountRow(account: entry.accounts[0])
                    .padding()
            } else {
                Text("No account added yet")
                    .font(.system(size: 13))
            }
        }
    }
}

struct AuthenticatorWidgetLargeView: View {
    let entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            if entry.accounts.count > 0 {
                AccountRow(account: entry.accounts[0])
                    .padding(.horizontal)
                AccountRow(account: entry.accounts[1])
                    .padding(.horizontal)
            } else {
                Text("No account added yet")
                    .font(.system(size: 13))
            }
        }
    }
}

@main
struct AuthenticatorWidget: Widget {
    let kind: String = "AuthenticatorWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            AuthenticatorWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium, .systemLarge])
        .configurationDisplayName("Authenticator")
        .description("This is an example widget.")
    }
}

//struct Provider: IntentTimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
//    }
//
//    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(), configuration: configuration)
//        completion(entry)
//    }
//
//    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let configuration: ConfigurationIntent
//}
//
//struct AuthenticatorWidgetEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        Text(entry.date, style: .time)
//    }
//}
//
//@main
//struct AuthenticatorWidget: Widget {
//    let kind: String = "AuthenticatorWidget"
//
//    var body: some WidgetConfiguration {
//        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
//            AuthenticatorWidgetEntryView(entry: entry)
//        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
//    }
//}
//
struct AuthenticatorWidget_Previews: PreviewProvider {
    static var previews: some View {
        let accounts = [
            Account(issuer: "Microsoft", name: "email@mail.com", secret: "DREERRRR", digits: 6, timeInterval: 30, algorithm: .sha1),
            Account(issuer: "Google", name: "email@mail.com", secret: "DRES", digits: 6, timeInterval: 30, algorithm: .sha1),
            Account(issuer: "Dropbox", name: "email@mail.com", secret: "SDOS", digits: 6, timeInterval: 30, algorithm: .sha1)
        ]
        
        AuthenticatorWidgetEntryView(entry: AccountEntry(date: Date(), accounts: accounts))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        
        AuthenticatorWidgetEntryView(entry: AccountEntry(date: Date(), accounts: accounts))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
