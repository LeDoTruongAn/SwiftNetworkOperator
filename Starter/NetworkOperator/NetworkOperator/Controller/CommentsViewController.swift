//
//  CommentsViewController.swift
//  NetworkOperator
//
//  Created by An Le on 2/4/17.
//  Copyright © 2017 Maniac Mobility. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource {

    //MARK: Property Instances
    var postId: Int = 0
    var listComments: [CommentModel]?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup TablView
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        //Call Web Service
    }
    
    //MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listComments != nil ? (listComments?.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.kCellIdentifier, for: indexPath) as! CommentTableViewCell
        let model = listComments?[indexPath.row]
        cell.setUpCell(model!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(CommentTableViewCell.kCellHeight)
    }

}
