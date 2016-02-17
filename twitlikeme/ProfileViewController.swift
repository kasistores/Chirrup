//
//  ProfileViewController.swift
//  twitlikeme
//
//  Created by Kevin Asistores on 2/15/16.
//  Copyright © 2016 Kevin Asistores. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController {
    
    var tweet: Tweet?
    var user: User?
    
    var tweets: [Tweet]?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImageView.layer.cornerRadius = 10.0
        let profileImage = self.user!.profileImageURL!
        let profileView = NSURL(string: profileImage)!
        profileImageView.setImageWithURL(profileView)
        
        self.nameLabel.text = user!.name
        self.userNameLabel.text = user!.screenName
        self.tweetCount.text = user!.tweetCount
        self.followerCount.text = user!.followerCount
        self.followingCount.text = user!.followingCount
        
        // Do any additional setup after loading the view.
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
