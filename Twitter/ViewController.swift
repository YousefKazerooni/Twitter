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
        
        //have to create the loginWithCompletion method in TwitterClient
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: user?, error: NSError?) in
            if user != nil{
                //perform seque
            }else {
                // handle login error
            }
        }
        
     
    }

}

