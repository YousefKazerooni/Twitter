//
//  DetailsViewController.swift
//  Twitter
//
//  Created by Yousef Kazerooni on 2/25/16.
//  Copyright © 2016 Yousef Kazerooni. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var userNameHandle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var tweet: Tweet!
    
    //declaring tweetCell just so that I can access the timestamp function
    //???????var tweetCell: TweetCell?


    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(tweet)")
        userNameLabel.text = "\((tweet.user?.name)!)"
        userNameHandle.text = "@" + "\((tweet.user?.screenname)!)"
        tweetTextLabel.text = tweet.text
        
        //Retrieving the image
        let imageUrl = tweet.user?.profileImageUrl!
        profilePictureImageView.setImageWithURL(NSURL(string: imageUrl!)!)
        
        //???????dateLabel.text = tweetCell!.calculateTimeStamp(tweet.createdAt!.timeIntervalSinceNow)
    

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
