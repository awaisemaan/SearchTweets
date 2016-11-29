//
//  TweetDetail.swift
//  SearchTweets
//
//  Created by Synnapps on 29/11/2016.
//  Copyright © 2016 awais. All rights reserved.
//

import UIKit

class TweetDetail: UIViewController {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    public var tweetObject: Tweet?
    
    //MARK : ViewController Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateValues()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    func populateValues() -> Void {
        let url = tweetObject?.user?.profile_image_url?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let imgURL : NSURL = NSURL(string: url! as String)!
        
        lblName.text = tweetObject?.user?.name as String?
        lblText.text = tweetObject?.text as String?
        imgUser.sd_setImage(with: imgURL as URL)
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
