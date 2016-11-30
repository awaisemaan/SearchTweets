//
//  Tweet.swift
//  SearchTweets
//
//  Created by Synnapps on 29/11/2016.
//  Copyright © 2016 awais. All rights reserved.
//

import UIKit
import ObjectMapper

class Tweet: Mappable {
    
    var created_at: NSString?
    var text: NSString?
    var user: User?
    
    required init?(map: Map) {
        
    }
    
    init(date: String, textTweet: String, userTweet: User) {
        self.created_at = date as NSString?
        self.text = textTweet as NSString?
        self.user = userTweet
    }
    
    // Mappable
    
    func mapping(map: Map) {
        created_at   <- map["created_at"]
        text  <- map["text"]
        user <- map["user"]
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let created_at = decoder.decodeObject(forKey: "created_at") as? String,
            let text = decoder.decodeObject(forKey: "text") as? String,
            let user = decoder.decodeObject(forKey: "user") as? User
            else { return nil }
        
        self.init(
            date: created_at,
            textTweet: text,
            userTweet: user
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encode(self.created_at, forKey: "created_at")
        coder.encode(self.text, forKey: "text")
        coder.encode(self.user, forKey: "user")
    }
    
}
