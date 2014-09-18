//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by Gautham Krishna on 9/14/14.
//  Copyright (c) 2014 Gautham Krishna. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var movies: [NSDictionary] = []
    var refreshCtrl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorLabel.hidden = false
        tableView.delegate = self
        tableView.dataSource = self
        self.errorLabel.alpha = 0
        
        
        self.refreshCtrl = UIRefreshControl()
        self.refreshCtrl.attributedTitle = NSAttributedString(string: "Pull down to refresh..")
        self.refreshCtrl.addTarget(self, action: "loadMovies", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshCtrl)
        
    }

    override func viewDidAppear(animated: Bool) {
        ProgressHUD.show("Loading movies...")
        loadMovies()
    }

    func loadMovies() {
        self.refreshCtrl.beginRefreshing()
        ProgressHUD.show("Loading movies..")
        
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
        
        var request = NSURLRequest(URL: NSURL(string: url))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            if(data == nil) {
                //show the error label
                ProgressHUD.showError("Could not fetch movies")
                self.errorLabel.alpha = 1
            }else {
                self.errorLabel.alpha = 0
                self.movies = object["movies"] as [NSDictionary]
                ProgressHUD.dismiss()
                self.refreshCtrl.endRefreshing()
            }
            
            self.tableView.reloadData()
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
            var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
            
            var movie = movies[indexPath.row]
            cell.movieTitleLabel.text = movie["title"] as? String
            cell.synopsisLabel.text = movie["synopsis"] as? String
            
            var posters = movie["posters"] as NSDictionary
            var posterUrl = posters["thumbnail"] as String
            
            cell.thumbImage.setImageWithURL(NSURL(string: posterUrl))
            
            return cell
            
        }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var indexPath = tableView.indexPathForSelectedRow()
        var movie = movies[indexPath!.row]
        
        var detailsViewController = segue.destinationViewController as MovieDetailsViewController
        detailsViewController.movie = movie
        
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
