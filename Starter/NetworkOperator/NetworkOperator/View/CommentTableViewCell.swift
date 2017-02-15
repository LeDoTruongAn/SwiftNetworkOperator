//
//  CommentTableViewCell.swift
//  NetworkOperator
//
//  Created by An Le on 2/4/17.
//  Copyright © 2017 Maniac Mobility. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    static let kCellIdentifier = "CommentTableViewCell"
    static let kCellHeight = 180
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setUpCell(_ cmnt: CommentModel) {
        userNameLabel.text = cmnt.name
        emailLabel.text = cmnt.email
        bodyTextView.text = cmnt.body
    }

}
