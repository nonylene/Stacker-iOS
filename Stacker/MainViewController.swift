//
//  MainViewController.swift
//  Stacker
//
//  Created by nonylene on 3/9/16.
//  Copyright © 2016 nonylene. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var questionTableView: UITableView!

    private var questions = [Question]()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        questionTableView.dataSource = self
        questionTableView.delegate  = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchText = searchBar.text

        let url = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=" + searchText!.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())! + "&site=stackoverflow&filter=!6JEajsykLFu3W"

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
                    let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary as! [String: AnyObject]
                    self.questions = (dict["items"] as! [[String: AnyObject]]).map{ item -> Question in
                        Question(dict: item)
                    }
                    self.questionTableView.reloadData()
                }
            })
        }).resume()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("questionCell", forIndexPath: indexPath) as! QuestionTableViewCell
        cell.question = questions[indexPath.row]

        return cell
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
