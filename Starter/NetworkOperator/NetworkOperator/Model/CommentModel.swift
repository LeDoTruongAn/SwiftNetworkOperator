//
//  CommentModel.swift
//  NetworkOperator
//
//  Created by An Le on 2/4/17.
//  Copyright © 2017 Maniac Mobility. All rights reserved.
//

import Foundation
import ObjectMapper

class CommentModel: Mappable {
    
    var postId: Int = 0
    var id: Int = 0
    var name: String = ""
    var email: String = ""
    var body: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        postId <- map["postId"]
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        body <- map["body"]
    }
}
