//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Gautham Krishna on 9/15/14.
//  Copyright (c) 2014 Gautham Krishna. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movie: NSDictionary = [:]

    @IBOutlet weak var posterBgImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var audienceScore: UILabel!
    @IBOutlet weak var criticScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var title = movie["title"] as? String

        //Image
        var posters = movie["posters"] as NSDictionary
        var posterThumbUrl = posters["thumbnail"] as String
        var originalUrl = posterThumbUrl.stringByReplacingOccurrencesOfString("tmb", withString: "org", options: NSStringCompareOptions.LiteralSearch, range: nil)
        posterBgImageView.setImageWithURL(NSURL(string: originalUrl))
        
        //Ratings
        
        var ratings = movie["ratings"] as NSDictionary
        criticScore.text = ratings["critics_score"] as? String
        audienceScore.text = ratings["audience_score"] as? String

        //Navigation
        self.navigationItem.backBarButtonItem?.title = "Movies"
        self.navigationItem.title = title
        
        //Summary
        synopsisLabel.text = self.movie["synopsis"] as? String

        
        //Title
        movieTitle.text = title
        
        scrollView.backgroundColor = UIColor.clearColor()
        containerView.backgroundColor = UIColor.clearColor()
        synopsisLabel.backgroundColor = UIColor.clearColor()

        scrollView.contentSize = CGSize(width:320, height:600)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
