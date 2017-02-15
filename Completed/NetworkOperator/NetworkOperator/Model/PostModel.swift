//
//  PostModel.swift
//  NetworkOperator
//
//  Created by An Le on 2/4/17.
//  Copyright © 2017 Maniac Mobility. All rights reserved.
//

import Foundation
import ObjectMapper

class PostModel : Mappable {
    
    var userId: Int = 0
    var id: Int = 0
    var title: String = ""
    var body: String = ""
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
    }
}
