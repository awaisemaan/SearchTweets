//
//  SearchTweetsVC.swift
//  SearchTweets
//
//  Created by Synnapps on 28/11/2016.
//  Copyright © 2016 awais. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchTweetsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tblSearchTweets: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let cellIdentifier = "tweet_cell" as String
    
    var TweetsArray: NSMutableArray = []
    
    // MARK: ViewController Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureFunc()
    }
    
    func configureFunc() -> Void {
        self.tblSearchTweets.register(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tblSearchTweets.estimatedRowHeight = 140;
        self.tblSearchTweets.rowHeight = UITableViewAutomaticDimension;
        self.checkAuthentication()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkAuthentication() -> Void {
        let twitterOAuth = TwitterOAuthClass.sharedInstance
        twitterOAuth.authenticate { () in
        }
    }
    
    // MARK: Action Methods
    
    @IBAction func onClickBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: UITableView Delegate and DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.TweetsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TweetCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TweetCell
        let tweet:Tweet = TweetsArray.object(at: indexPath.row) as! Tweet;
        cell.setTweet(tweet: tweet)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tweet:Tweet = TweetsArray.object(at: indexPath.row) as! Tweet;
        let TweetDetailStoryBoard = UIStoryboard(name: "TweetDetail", bundle: nil)
        let tweetDetailVC = TweetDetailStoryBoard.instantiateViewController(withIdentifier: "tweet_detail") as! TweetDetail
        tweetDetailVC.tweetObject = tweet as Tweet
        self.navigationController?.pushViewController(tweetDetailVC, animated: true)
    }
    
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: SearchBar Delegate Methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SVProgressHUD.show(withStatus: "Searching..")
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(searchFunc), userInfo: nil, repeats: false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchFunc() -> Void {
        let twitterOAuth = TwitterOAuthClass.sharedInstance
        if(twitterOAuth.isAuthenticated) {
            twitterOAuth.searchTweets(screenName: searchBar.text! as String, completionBlock: { (tweetsArray) in
                self.TweetsArray = tweetsArray as NSMutableArray
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.tblSearchTweets.reloadData()
                    }
                }
            })
        }
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
