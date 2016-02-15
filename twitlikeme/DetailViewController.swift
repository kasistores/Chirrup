//
//  DetailViewController.swift
//  twitlikeme
//
//  Created by Kevin Asistores on 2/14/16.
//  Copyright © 2016 Kevin Asistores. All rights reserved.
//

import UIKit
import AFNetworking

class DetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    var tweet: Tweet?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImageView.layer.cornerRadius = 10.0
        
        let profileImage = self.tweet!.user?.profileImageURL
        let profileView = NSURL(string: profileImage!)
        profileImageView.setImageWithURL(profileView!)
        
        let fullName = self.tweet!.user?.name
        nameLabel.text = fullName
        
        let userName = self.tweet!.user?.screenName
        usernameLabel.text = userName
        
        let tweet = self.tweet?.text
        tweetLabel.text = tweet
        
        
        

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
