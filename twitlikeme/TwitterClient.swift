//
//  TwitterClient.swift
//  twitlikeme
//
//  Created by Kevin Asistores on 2/2/16.
//  Copyright © 2016 Kevin Asistores. All rights reserved.
//


import UIKit
import AFNetworking
import BDBOAuth1Manager

let twitterConsumerKey = "NEYV8LKFEutwFeb0mZky7Qovj"
let twitterConsumerSecret = "FHvCrwI7LSge3vJhNu8xKWcJddi0FuXpNH4pGnrqDSvdLCLWsq"
let twitterBaseURL = NSURL(string: "http://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    
}
