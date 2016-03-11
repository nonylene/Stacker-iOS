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
            bindQuestion(question!)
        }
    }

    private func bindQuestion(question: Question) {
        countLabel.text = String(question.upVoteCount)
        checkImageView.hidden = !question.isAnswered

        // convert html to string
        let titleAttrStr = try! NSAttributedString(
            data: question.title.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        titleLabel.text = titleAttrStr.string

        tagLabel.text = question.tags.joinWithSeparator(" ")

        let bodyAttrStr = try! NSAttributedString(
            data: question.body.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        bodyLabel.text = bodyAttrStr.string

        let date_formatter: NSDateFormatter = NSDateFormatter()
        date_formatter.locale = NSLocale(localeIdentifier: "ja")
        date_formatter.dateFormat = "yyyy/MM/dd"
        dateLabel.text =  date_formatter.stringFromDate(question.creationDate)
        authorLabel.text = question.ownerName
    }
}