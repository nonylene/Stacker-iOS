//
//  QuestionTableViewCell.swift
//  Stacker
//
//  Created by nonylene on 3/10/16.
//  Copyright © 2016 nonylene. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    var question: Question? {
        didSet {
            setQuestion(question!)
        }
    }

    private func setQuestion(question: Question) {
        countLabel.text = String(question.upVoteCount)
        checkImageView.hidden = !question.isAnswered
        titleLabel.text = question.title
        tagLabel.text = question.tags.joinWithSeparator(" ")
        bodyLabel.text = question.body

        let date_formatter: NSDateFormatter = NSDateFormatter()
        date_formatter.locale = NSLocale(localeIdentifier: "ja")
        date_formatter.dateFormat = "yyyy/MM/dd"
        dateLabel.text =  date_formatter.stringFromDate(question.creationDate)
        authorLabel.text = question.ownerName
    }
}