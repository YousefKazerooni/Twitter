//
//  TweetCell.swift
//  Twitter
//
//  Created by Yousef Kazerooni on 2/13/16.
//  Copyright © 2016 Yousef Kazerooni. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userNameHandle: UILabel!
    
    var tweet: Tweet! {
        
        
        didSet {
           userNameLabel.text = "\((tweet.user?.name)!)"
           userNameHandle.text = "@" + "\((tweet.user?.screenname)!)"
           tweetTextLabel.text = tweet.text
           dateLabel.text = "\(tweet.createdAt!)"
            
            //Retrieving the image
            let imageUrl = tweet.user?.profileImageUrl!
            profilePictureImageView.setImageWithURL(NSURL(string: imageUrl!)!)
            
            
// Another way of saying the code above
//            if let user = tweet.user {
//                userNameLabel.text = "\(tweet.user!)"
//            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
