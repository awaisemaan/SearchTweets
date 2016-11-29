//
//  ViewController.swift
//  SearchTweets
//
//  Created by Synnapps on 28/11/2016.
//  Copyright © 2016 awais. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickSearchTweets(_ sender: AnyObject) {
        let searchTweetsStoryBoard = UIStoryboard(name: "SearchTweets", bundle: nil)
        let searchTweetsCV = searchTweetsStoryBoard.instantiateViewController(withIdentifier: "search_tweets") as! SearchTweetsVC
        self.navigationController?.pushViewController(searchTweetsCV, animated: true)
    }
}

