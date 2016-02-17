//
//  ComposeViewController.swift
//  twitlikeme
//
//  Created by Kevin Asistores on 2/16/16.
//  Copyright © 2016 Kevin Asistores. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var tweetField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSend(sender: AnyObject) {
        let tweet = tweetField.text
        
        if tweet != "" {
            TwitterClient.sharedInstance.test(tweet!)
        }
        dismissViewControllerAnimated(true, completion: nil)
        
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
