//
//  TableViewCell.swift
//  twitlikeme
//
//  Created by Kevin Asistores on 2/7/16.
//  Copyright © 2016 Kevin Asistores. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell{

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    var retweeted: Bool?
    var favorited: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImageView.layer.cornerRadius = 10.0
        
        let UITapRecognizer = UITapGestureRecognizer(target: self, action: "tappedImage:")
        UITapRecognizer.delegate = self
        self.profileImageView.addGestureRecognizer(UITapRecognizer)
        self.profileImageView.userInteractionEnabled = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
