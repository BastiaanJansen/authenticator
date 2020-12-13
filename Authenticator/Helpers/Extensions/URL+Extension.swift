//
//  URL+Extension.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 08/12/2020.
//

import Foundation
import UIKit

extension URL {
    enum Link: String {
        case github = "https://github.com/BastiaanJansen"
    }
    
    init?(link: Link) {
        self.init(string: link.rawValue)
    }
    
    static func open(link: Link) {
        if let url = URL(link: link), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    static func open(url link: String) {
        if let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

extension URL {
    var queryDictionary: [String: String]? {
        guard let query = self.query else { return nil }

        var queryStrings = [String: String]()
        for pair in query.components(separatedBy: "&") {

            let key = pair.components(separatedBy: "=")[0]

            let value = pair
                .components(separatedBy:"=")[1]
                .replacingOccurrences(of: "+", with: " ")
                .removingPercentEncoding ?? ""

            queryStrings[key] = value
        }
        return queryStrings
    }
}
