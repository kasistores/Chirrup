//
//  TweetsViewController.swift
//  twitlikeme
//
//  Created by Kevin Asistores on 2/7/16.
//  Copyright © 2016 Kevin Asistores. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    @IBAction func retweetButton(sender: AnyObject) {
        
    }
    
    @IBAction func likeButton(sender: AnyObject) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tweets != nil{
            return tweets!.count
        }
        else{
            return 0
        }
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
        let tweet = tweets![indexPath.row]
        
        let tweetFavorited = tweet.fav
        let tweetRetweeted = tweet.retweet
        let favCount = tweet.favCount
        let retweetCount = tweet.retweetCount
        cell.retweeted = tweetFavorited
        cell.favorited = tweetRetweeted
        if favCount! == 0 {
            cell.likeLabel.hidden = true
            cell.likeLabel.text = "\(favCount!)"
            //print(tweetFavoriteCount!)
        } else {
            cell.likeLabel.hidden = false
            cell.likeLabel.text = "\(favCount!)"
            //print(tweetFavoriteCount!)
        }
        
        if retweetCount! == 0 {
            cell.retweetLabel.hidden = true
            cell.retweetLabel.text = "\(retweetCount!)"
        } else {
            cell.retweetLabel.hidden = false
            cell.retweetLabel.text = "\(retweetCount!)"
            
        }
        
        cell.tweetLabel.text = tweet.text
        cell.usernameLabel.text = tweet.user?.name
        cell.dateLabel.text = tweet.createdAtString
        let profileImage = tweet.user?.profileImageURL
        let profileView = NSURL(string: profileImage!)
        cell.profileImageView.setImageWithURL(profileView!)
        //cell.likeLabel.text = tweet.favCount as! String

        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //var senderCell = sender!.superview!!.superview!
            
            //print("congrats you just pressed a cell")
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = self.tweets![indexPath!.row]
            let detailsViewController = segue.destinationViewController as! DetailViewController
            
            detailsViewController.tweet = tweet
            
            // obj is not a string array
        
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.clearColor()
            cell.selectedBackgroundView = backgroundView
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    

}
