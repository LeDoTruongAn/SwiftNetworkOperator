//
//  PostTableViewCell.swift
//  NetworkOperator
//
//  Created by An Le on 2/4/17.
//  Copyright © 2017 Maniac Mobility. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    static let kCellIdentifier = "PostTableViewCell"
    static let kCellHeight = 150
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setUpCell(_ post: PostModel) {
        titleLabel.text = post.title
        bodyTextView.text = post.body
    }

}
