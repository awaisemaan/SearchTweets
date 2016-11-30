//
//  TwitterOAuthClass.swift
//  SearchTweets
//
//  Created by Synnapps on 28/11/2016.
//  Copyright © 2016 awais. All rights reserved.
//

import UIKit
import SwiftHTTP
import ObjectMapper

class TwitterOAuthClass: NSObject {
    
    private var accessToken: String!
    //Enter your Twitter Application Keys
    private let consumerKey =
    private let consumerSecret = 
    private let baseUrlString = "https://api.twitter.com/oauth2/token"
    private let pageSize = 100

    
    var isAuthenticated : Bool = false
    
    static let sharedInstance : TwitterOAuthClass = {
        let instance = TwitterOAuthClass()
        return instance
    }()
    
    func checkAuthentication() -> Bool {
        return isAuthenticated
    }
    
    public func authenticate(completionBlock:@escaping (Void) -> ()) {
        if accessToken != nil {
            completionBlock()
        }
        
        let credentials = "\(consumerKey):\(consumerSecret)"
        let headers = ["Authorization": "Basic \(credentials.getBase64())", "Content-Type":"application/x-www-form-urlencoded", "Accept-Encoding":"gzip"]
        let params = ["grant_type":"client_credentials"]
        
        do {
            let opt = try HTTP.POST(baseUrlString, parameters: params, headers: headers)
            opt.start { response in
                if(response.statusCode == 200) {
                    do {
                        let responseObject = try JSONSerialization.jsonObject(with: response.data, options: []) as! [String:AnyObject]
                        self.accessToken = responseObject["access_token"] as? String
                        self.isAuthenticated = true
                        completionBlock()
                    } catch let error as NSError {
                        print("error: \(error.localizedDescription)")
                    }
                }
            }
        } catch let error {
            print("couldn't serialize the paraemeters: \(error)")
        }
    }
    
    public func searchTweets(screenName: String, completionBlock:@escaping (NSMutableArray) -> ()) {
        if(isAuthenticated) {
            do {
                let headers = ["Authorization": "Bearer \(self.accessToken!)"]
                let params: [String : AnyObject] = [
                    "q" : screenName as AnyObject,
                    "count": self.pageSize as AnyObject
                ]
                
                let opt = try HTTP.GET("https://api.twitter.com/1.1/search/tweets.json", parameters: params, headers: headers)
                opt.start { response in
                    if(response.statusCode == 200) {
                        do {
                            let responseObject = try JSONSerialization.jsonObject(with: response.data, options: []) as! [String:AnyObject]
                            let tweetsArray = responseObject["statuses"] as? NSArray
                            let searchedResults: NSMutableArray = []
                            
                            for tweet in tweetsArray as! [NSDictionary] {
                                
                                let jsonData = try JSONSerialization.data(withJSONObject: tweet, options: .prettyPrinted)
                                let theJSONText = NSString(data: jsonData, encoding: String.Encoding.ascii.rawValue)
                                let searchedTweet = Mapper<Tweet>().map(JSONString: theJSONText as! String)
                                searchedResults.add(searchedTweet)
                            }
                            
                            completionBlock(searchedResults)
                            print(responseObject)
                        } catch let error as NSError {
                            print("error: \(error.localizedDescription)")
                        }
                    }
                    else {
                        completionBlock([])
                    }
                }
            } catch let error {
                print("couldn't serialize the paraemeters: \(error)")
            }
        }
        else {
            print("Authentication Error")
        }
    }

}
