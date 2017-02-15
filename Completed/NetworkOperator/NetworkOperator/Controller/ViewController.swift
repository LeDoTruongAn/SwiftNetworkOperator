//
//  ViewController.swift
//  NetworkOperator
//
//  Created by An Le on 2/4/17.
//  Copyright © 2017 Maniac Mobility. All rights reserved.
//

import UIKit
import ObjectMapper
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK:- Properties
    var listPosts: [PostModel]?
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        retrievePost()
    }

    private func retrievePost() {
        let connector = Connector(self)
        connector.request = APIRequest(connector, endPoint: EndPoint.posts, method: HttpMethod.get, data: nil, param: "?userId=1")
        connector.connect()
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
        
        if segue.identifier == "PresentComments" {
            let vc = segue.destination as! CommentsViewController
            let model = listPosts?[(tableView.indexPathForSelectedRow?.row)!]
           vc.postId = (model?.id)!
        }
    }
    
}
//MARK:- Implement Connector Delegate
extension ViewController: ConnectorDelegate {
    
    func connector(_ connector: Connector, didSucceedWithResult result: Any?) {
        if let array = result as? [[String: AnyObject]] {
            listPosts = []
            for object in array {
                // access all objects in array
                listPosts?.append(Mapper<PostModel>().map(JSON: object)!)

            }
            tableView.reloadData()
        }
        print("I'm here")
    }
    
    func connector(_ connector: Connector, didFailWithMessage message: String?) {
        print("I'm here")
    }
}

