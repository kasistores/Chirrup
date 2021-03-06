
//
//  Tweet.swift
//  twitlikeme
//
//  Created by Kevin Asistores on 2/7/16.
//  Copyright © 2016 Kevin Asistores. All rights reserved.
//

import UIKit
import AFNetworking

class Tweet: NSObject {
    
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var profileImageURL: String?
    var retweetCount: Int?
    var favCount: Int?
    var retweet: Bool?
    var fav: Bool?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        profileImageURL = dictionary["profile_image_url"] as? String
        retweetCount = dictionary["retweet_count"] as? Int
        favCount = dictionary["favorite_count"] as? Int
        retweet = dictionary["retweeted"] as? Bool
        fav = dictionary["favorited"] as? Bool

        
        
        //let timeElapsed = Int(0 - (createdAt?.timeIntervalSinceNow)!)
    }
    
    class func tweetswithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
    
}
