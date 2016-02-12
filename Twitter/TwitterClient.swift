//
//  TwitterClient.swift
//  Twitter
//
//  Created by Yousef Kazerooni on 2/8/16.
//  Copyright © 2016 Yousef Kazerooni. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
    
    let twitterBaseUrl = NSURL(string: "https://api.twitter.com")
    let twitterConsumerKey = "tUnMs3fqqBNPqIcbi857FHb7t"
    let twitterConsumerSecret = "VIfcaiXAZpl7GFVSU9rThbAYRITk537XoX4ynSFpNKZFN0UvKO"
    
    class TwitterClient: BDBOAuth1SessionManager {
        
        //the variable will hold the closer that we will use 
        //in loginWithCompletion, till we are ready to use it
        var loginCompletion: ((user: User?, error: NSError?) -> ())?
        
        
        class var sharedInstance: TwitterClient {
            struct Static {
                static let instance = TwitterClient(
                    baseURL: twitterBaseUrl,
                    consumerKey: twitterConsumerKey,
                    consumerSecret: twitterConsumerSecret)
            }
            
            return Static.instance
        }
        
        
        //creating the completion method to be used in controllviewer
        func  loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
            loginCompletion = completion
            
            //fetch my request token & redirect to authorization page
            //Initially we had this code on the viewController inside "onLogin"
            TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
            TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cputwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
                print ("got the request token.")
                
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                
                UIApplication.sharedApplication().openURL(authURL!)
                
                }) { (error: NSError!) -> Void in
                    print ("failed to get request token.")
                    self.loginCompletion?(user: nil, error: error)
                    
                    
            }
            
        }
        
        func openURL(url: NSURL) {
            fetchAccessTokenWithPath("oauth/access_token",
                method: "POST",
                requestToken: BDBOAuth1Credential(queryString: url.query),
                success: { (accessToken: BDBOAuth1Credential!) -> Void in
                    print("Got the access token!")
                    
                    TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                    TwitterClient.sharedInstance.GET(
                        "1.1/account/verify_credentials.json",
                        parameters: nil,
                        success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                            //print("user: \(response!)")
                            var user = User(dictionary: response as! NSDictionary)
                            print ("user: \(user.name)")
                            self.loginCompletion?(user: user, error: nil)
                        },
                        failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                            print("error getting current user")
                            self.loginCompletion?(user: nil, error: error)
                    })
                    
                    TwitterClient.sharedInstance.GET(
                        "1.1/statuses/home_timeline.json",
                        parameters: nil,
                        success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                            //print("home_timeline: \(response!)")
                            
                            
                            //Minute 10:15 second video -- testing something out?
                            //More checking to see if the code works so far
                            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                            
                            for tweet in tweets {
                                print ("text: \(tweet.text)") //still working on: created:tweet.createdAt
                                
                            }
                        },
                        failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                            print("error getting current user")
                            
                    })
                    
                },
                failure: { (error: NSError!) -> Void in
                    print("Failed to receive access token")
                    self.loginCompletion?(user: nil, error: error)
            })

            
            
            
        }
        
    }

