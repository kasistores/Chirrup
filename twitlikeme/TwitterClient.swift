//
//  TwitterClient.swift
//  twitlikeme
//
//  Created by Kevin Asistores on 2/2/16.
//  Copyright © 2016 Kevin Asistores. All rights reserved.
//


import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "NEYV8LKFEutwFeb0mZky7Qovj"
let twitterConsumerSecret = "FHvCrwI7LSge3vJhNu8xKWcJddi0FuXpNH4pGnrqDSvdLCLWsq"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Error getting request token: \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got access token")
            
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("It worked!!!")
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user:user, error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("It did not work")
                    self.loginCompletion?(user: nil, error: error)
                    
            })
            
            TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                //                print("It worked!!!")
                //                print("user: \(response)")
                let tweets = Tweet.tweetswithArray(response as! [NSDictionary])
                
                for tweet in tweets {
                    print("text: \(tweet.text), created: \(tweet.createdAt)")
                }
                
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("It did not work")
                    self.loginCompletion?(user: nil, error: error)
                    
            })
            
            }) { (error: NSError!) -> Void in
                print("An error occurred")
                self.loginCompletion?(user: nil, error: error)
                
        }
        
    }
    func test(message: String)
    {
        var newString = message.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        newString = newString.stringByReplacingOccurrencesOfString("'", withString: "%27", options: NSStringCompareOptions.LiteralSearch, range: nil)
        newString = newString.stringByReplacingOccurrencesOfString("#", withString: "%23", options: NSStringCompareOptions.LiteralSearch, range: nil)
        newString = newString.stringByReplacingOccurrencesOfString("@", withString: "%40", options: NSStringCompareOptions.LiteralSearch, range: nil)
        POST("https://api.twitter.com/1.1/statuses/update.json?status=\(newString)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                
        }
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            let tweets = Tweet.tweetswithArray(response as! [NSDictionary])
                completion(tweets: tweets, error: nil)
            
            }, failure:  { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
    })
    }
}