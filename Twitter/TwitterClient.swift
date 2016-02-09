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
        
        class var sharedInstance: TwitterClient {
            struct Static {
                static let instance = TwitterClient(
                    baseURL: twitterBaseUrl,
                    consumerKey: twitterConsumerKey,
                    consumerSecret: twitterConsumerSecret)
            }
            
            return Static.instance
        }
        
    }

