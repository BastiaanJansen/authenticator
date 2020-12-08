//
//  AlternateAppIconsListView.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 08/12/2020.
//

import SwiftUI

struct AlternateAppIconsListView: View {
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 40) {
                ForEach(AppIconService.AppIcon.allCases, id: \.self) { icon in
                    Button(action: {
                        AppIconService.changeIcon(to: icon)
                    }) {
                        Image(uiImage: UIImage(named: icon.rawValue) ?? UIImage())
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 65, height: 65)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
        }.navigationTitle("App icon")
    }
}

struct AlternateAppIconsListView_Previews: PreviewProvider {
    static var previews: some View {
        AlternateAppIconsListView()
    }
}
