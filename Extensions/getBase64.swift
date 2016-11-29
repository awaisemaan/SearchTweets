//
//  getBase64.swift
//  SearchTweets
//
//  Created by Synnapps on 28/11/2016.
//  Copyright © 2016 awais. All rights reserved.
//

import Foundation

public extension String {
    func getBase64() -> String {
        let credentialData = self.data(using: String.Encoding.utf8)!
        return credentialData.base64EncodedString()
    }
}

