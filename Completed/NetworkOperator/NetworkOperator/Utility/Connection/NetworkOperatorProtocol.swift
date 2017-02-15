//
//  NetworkOperatorProtocol.swift
//  NetworkOperator
//
//  Created by An Le on 2/5/17.
//  Copyright © 2017 Maniac Mobility. All rights reserved.
//

import Foundation

protocol APIRequestProtocol {
    
    //MARK:- Variables
    var delegate: NetworkConnectionDelegate? { get set }
    var endPoint: EndPoint { get set }
    var method: HttpMethod { get set }
    var urlSession: URLSession { get set }
    var data: Data? { get set }
    var param: String? { get set }
    var currentTask: URLSessionDataTask? { get set }
    //MARK: - methods
    func connect()
    func fullEndPoint() -> String
}

protocol ConnectorProtocol {
    
    //MARK:- Variables
    var request: APIRequest? { get set }
    var message: String? { get set }
    var delegate: ConnectorDelegate? { get set }
    var resultDict: [String: AnyObject]? { get set }
    var resultArray: [[String: AnyObject]]? { get set }
    
    //MARK:- Methods
    func connect()
    func drop()
}

protocol NetworkConnectionDelegate {
    func networkConnection(_ request: APIRequest, didFailWithError error: Error)
    func networkConnection(_ request: APIRequest, didSucceedWithResult result: AnyObject?)
}

protocol ConnectorDelegate {
    func connector(_ connector: Connector, didFailWithMessage message: String?)
    func connector(_ connector: Connector, didSucceedWithResult result: Any?)
}
