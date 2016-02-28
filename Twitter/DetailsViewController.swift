//
//  DetailsViewController.swift
//  Twitter
//
//  Created by Yousef Kazerooni on 2/25/16.
//  Copyright © 2016 Yousef Kazerooni. All rights reserved.
//

import UIKit
import AFNetworking


class DetailsViewController: UIViewController, TweetCellButtonDelegate {
    
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var userNameHandle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    
    //weak var buttonDelegate: TweetCellButtonDelegate?
    let detailsViewController = DetailsViewController!.self

    


    var tweetCell: TweetCell
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
    
    
    
    
    
//    @IBAction func onLike(sender: AnyObject) {
//        buttonDelegate?.retweetClicked(tweetCell)
//    }
//    
//    
//    @IBAction func onRetweet(sender: AnyObject) {
//        retweetClicked(TweetCell)
//    }
    
    
    
    
    //Functions used to satisfy the protocol
    func retweetClicked(tweetCell: TweetCell){
        TwitterClient.sharedInstance.retweet(Int(tweetCell.tweetID)!, params: nil, completion: {(error) -> () in
            tweetCell.retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: UIControlState.Selected)
            
            if tweetCell.retweetLabel.text! > "0" {
                tweetCell.retweetLabel.text = String(tweetCell.tweet.retweetCount! + 1)
            } else {
                tweetCell.retweetLabel.hidden = false
                tweetCell.retweetLabel.text = String(tweetCell.tweet.retweetCount! + 1)
            }
        })
        
    }
    func favoriteClicked(tweetCell: TweetCell){
        TwitterClient.sharedInstance.likeTweet(Int(tweetCell.tweetID)!, params: nil, completion: {(error) -> () in
            tweetCell.favoriteButton.setImage(UIImage(named: "like-action-on"), forState: UIControlState.Selected)
            
            if tweetCell.favoriteLabel.text! > "0" {
                tweetCell.favoriteLabel.text = String(tweetCell.tweet.likeCount! + 1)
            } else {
                tweetCell.favoriteLabel.hidden = false
                tweetCell.favoriteLabel.text = String(tweetCell.tweet.likeCount! + 1)
            }
        })
        
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
