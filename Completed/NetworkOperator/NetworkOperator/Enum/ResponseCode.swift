//
//  ResponseCode.swift
//  NetworkOperator
//
//  Created by An Le on 2/4/17.
//  Copyright © 2017 Maniac Mobility. All rights reserved.
//

import Foundation

enum ResponseCode: Int {
    case ok = 200
    case bad_request = 400
    case unauthorized = 401
    case not_found = 404
    case internal_server_error = 500
}


