//
//  TweetCell.swift
//  SearchTweets
//
//  Created by Synnapps on 29/11/2016.
//  Copyright © 2016 awais. All rights reserved.
//

import UIKit
import SDWebImage

class TweetCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblActualName: UILabel!
    @IBOutlet weak var lblText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setTweet(tweet: Tweet) {
        let url = tweet.user?.profile_image_url?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let imgURL : NSURL = NSURL(string: url! as String)!
        
        lblDate.text = tweet.created_at as String?
        lblName.text = tweet.user?.screen_name as String?
        lblActualName.text = tweet.user?.name as String?
        lblText.text = tweet.text as String?
        userImg.sd_setImage(with: imgURL as URL)
    }

    
}
