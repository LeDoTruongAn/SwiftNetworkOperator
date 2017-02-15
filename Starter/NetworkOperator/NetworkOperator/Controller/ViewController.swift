//
//  ViewController.swift
//  NetworkOperator
//
//  Created by An Le on 2/4/17.
//  Copyright © 2017 Maniac Mobility. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    //MARK:- Properties
    var listPosts: [PostModel]?
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        retrievePost()
    }
    
    private func retrievePost() {
      //Insert
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK:- TableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.kCellIdentifier, for: indexPath) as! PostTableViewCell
        let model = listPosts?[indexPath.row]
        cell.setUpCell(model!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPosts != nil ? (listPosts?.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(PostTableViewCell.kCellHeight)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentComments" {
            let vc = segue.destination as! CommentsViewController
            let model = listPosts?[(tableView.indexPathForSelectedRow?.row)!]
           vc.postId = (model?.id)!
        }
    }
}

