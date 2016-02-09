//
//  ViewController.swift
//  Twitter
//
//  Created by Yousef Kazerooni on 2/8/16.
//  Copyright © 2016 Yousef Kazerooni. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
    TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth_request_token", method: "GET", callbackURL: NSURL(string: "cputwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print ("got the request token.")
            }) { (error: NSError!) -> Void in
                print ("failed to get request token.")
        }
    }

}

