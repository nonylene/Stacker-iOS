//
//  MainViewController.swift
//  Stacker
//
//  Created by nonylene on 3/9/16.
//  Copyright © 2016 nonylene. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchText = searchBar.text

        let url = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=" + searchText!.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())! + "&site=stackoverflow&filter=!-*f(6pnztD5P"

        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler:  {data, response, error in
            // main thread
            dispatch_async(dispatch_get_main_queue(), {
                var errorMessage: String?
                if let error = error {
                    errorMessage = error.localizedDescription
                } else if (response as! NSHTTPURLResponse).statusCode / 100 != 2 {
                    errorMessage = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
                }
                if let message = errorMessage {
                    let alert = UIAlertController(title: "Failed...", message: message, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    let message = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
                    let alert = UIAlertController(title: "Success", message: message, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
        }).resume()
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
