//
//  User.swift
//  SearchTweets
//
//  Created by Synnapps on 29/11/2016.
//  Copyright © 2016 awais. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Mappable {
    var profile_image_url: NSString?
    var description: NSString?
    var name: NSString?
    var screen_name: NSString?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        profile_image_url   <- map["profile_image_url"]
        description   <- map["description"]
        name   <- map["name"]
        screen_name   <- map["screen_name"]
    }
}
