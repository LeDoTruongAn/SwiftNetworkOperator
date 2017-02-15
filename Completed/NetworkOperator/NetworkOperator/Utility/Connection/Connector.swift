//
//  Connector.swift
//  NetworkOperator
//
//  Created by An Le on 2/4/17.
//  Copyright © 2017 Maniac Mobility. All rights reserved.
//

import Foundation

//MARK:- Connector Implementation
class Connector: NetworkConnectionDelegate, ConnectorProtocol {
    
    var request: APIRequest?
    var resultDict: [String : AnyObject]? = nil
    var resultArray: [[String : AnyObject]]?
    var delegate: ConnectorDelegate?
    var message: String?
    
    init(_ delegate: ConnectorDelegate) {
        self.delegate = delegate
    }
    
    func connect() {
      
        if let request = self.request {
            
            request.connect()
        }
    }
    
    func drop() {
        if let request = self.request {
            
            if let task = request.currentTask {
                task.cancel()
            }
        }
    }
    
}
//MARK:- Network Connection Delegate Implementation
extension Connector {
    
    func networkConnection(_ request: APIRequest, didFailWithError error: Error) {

        if let delegate = self.delegate{
            delegate.connector(self, didFailWithMessage: error.localizedDescription)
        }
        
    }
    func networkConnection(_ request: APIRequest, didSucceedWithResult result: AnyObject?) {
        
        if let resultDictionary = result as? [String: AnyObject] {
            self.resultDict = resultDictionary
        }
        
        if let array = result as? [Any?] {
            self.resultArray = []
            for object in array {
                // access all objects in array
                if let dict = object as? [String: AnyObject] {
                    if dict.keys.count > 0 {
                        self.resultArray?.append(dict)
                    }
                }
            }
        }
        
        if let delegate = self.delegate {
            if resultDict != nil || (resultArray?.count)! > 0 {
                delegate.connector(self, didSucceedWithResult:  resultDict != nil ? resultDict : resultArray)
                return
            }
            delegate.connector(self, didFailWithMessage: "No Item Found!")
        }
        
        
    }
}
