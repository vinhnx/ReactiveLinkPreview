//
//  URLBuilder.swift
//  reactive_link_preview
//
//  Created by Vinh Nguyen on 8/6/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation

struct URLBuilder {
    static func build(_ urlString: String) -> URL {
        let https = "https://"
        if urlString.hasPrefix(https) {
            return URL(string: urlString)!
        }

        return URL(string: (https + urlString))!
    }
}
