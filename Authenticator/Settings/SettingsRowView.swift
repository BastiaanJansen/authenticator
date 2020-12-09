//
//  SettingsRowView.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 09/12/2020.
//

import SwiftUI

struct SettingsRowView: View {
    var text: String
    var textColor: Color?
    var icon: Image?
    var iconColor: Color = .accentColor
    var iconSize: Image.Scale = .large
        
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            if let icon = icon {
                icon.imageScale(iconSize).foregroundColor(iconColor).frame(width: 30)
            }
            
            VStack(alignment: .leading) {
                Text(text).if(textColor != nil) {
                    $0.foregroundColor(textColor)
                }
            }
        }
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(text: "Text", icon: Image(systemName: "plus.circle.fill"))
    }
}
