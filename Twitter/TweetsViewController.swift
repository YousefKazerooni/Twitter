//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Yousef Kazerooni on 2/13/16.
//  Copyright © 2016 Yousef Kazerooni. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellButtonDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        apiNetworkRequest()
        
        // Initialize a UIRefreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    
    func apiNetworkRequest () {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
        
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
       let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.buttonDelegate = self
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    //**********2 RefreshControl
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        
        // Make network request to fetch latest data
        apiNetworkRequest()
        // Do the following when the network request comes back successfully:
        // Update tableView data source
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
   
    
    
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


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexpath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexpath!.row] 
        
        let detailsViewController = segue.destinationViewController as! DetailsViewController
        detailsViewController.tweet = tweet
        
        
    
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
