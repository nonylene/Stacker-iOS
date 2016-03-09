//
//  Question.swift
//  Stacker
//
//  Created by nonylene on 3/9/16.
//  Copyright © 2016 nonylene. All rights reserved.
//

import Foundation

class Question {

    let isAnswered: Bool
    let ownerName: String
    let upVoteCount: Int
    let creationDate: NSDate
    let body: String
    let link: String
    let title: String
    let tags: [String]

    init(dict: [String: AnyObject]) {
        isAnswered = dict["is_answered"] as! Bool
        upVoteCount = dict["up_vote_count"] as! Int
        body = dict["body"] as! String
        link = dict["link"] as! String
        title = dict["title"] as! String
        tags = dict["tags"] as! [String]
        creationDate = NSDate(timeIntervalSince1970: dict["creation_date"] as! Double)

        let owner = dict["owner"] as! [String: AnyObject]
        ownerName = owner["display_name"] as! String
    }
}
