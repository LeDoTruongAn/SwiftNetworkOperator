//
//  NetworkConnection.swift
//  NetworkOperator
//
//  Created by An Le on 2/4/17.
//  Copyright © 2017 Maniac Mobility. All rights reserved.
//

import Foundation

class APIRequest: APIRequestProtocol {
    
    internal var urlSession: URLSession
    internal var delegate: NetworkConnectionDelegate?
    internal var endPoint: EndPoint
    internal var method: HttpMethod
    internal var data: Data?
    internal var param: String?
    internal var currentTask: URLSessionDataTask?
    
    static let root = "https://jsonplaceholder.typicode.com"
    
    init(_ delegate: NetworkConnectionDelegate, endPoint: EndPoint, method: HttpMethod, data: Data?, param: String?) {
        self.delegate = delegate
        self.endPoint = endPoint
        self.method = method
        urlSession = URLSession (
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main)
        self.data = data
        self.param = param
    }
}

//MARK:- API Request Protocol Implementation
extension APIRequest {
    
    func fullEndPoint() -> String {
        var url = "\(APIRequest.root)\(self.endPoint.rawValue)"
        
        if let param = self.param {
            url = url + "/\(param)"
        }
        
        return url
    }
    
    func connect() {
        
        // Network Validating...
        guard Reachability.isInternetAvailable() else {
            let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("NO_NETWORK_MESSAGE", comment: "")]
            let error = NSError(domain: NSCocoaErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: userInfo)
            
            if let delegate = self.delegate{
                delegate.networkConnection(self, didFailWithError: error)
            }
            return
        }
        
        
        //URL Validating...
        let url = URL(string: fullEndPoint())
        guard url != nil else {
            let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Malformed URL message", comment: "")]
            let error = NSError(domain: NSCocoaErrorDomain, code: NSURLErrorBadURL, userInfo: userInfo)
            if let delegate = self.delegate{delegate.networkConnection(self, didFailWithError: error)}
            return
        }
        
        
        //Setup URL Request by URL
        let urlRequest = NSMutableURLRequest(url: url!)
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = self.method.rawValue
        if self.data != nil {
            urlRequest.httpBody = self.data!
        }
        
        let task = self.urlSession.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                if let delegate = self.delegate{delegate.networkConnection(self, didFailWithError: error!)}
                return
            }
            let httpResponse = response as? HTTPURLResponse
            guard httpResponse != nil else {
                print("Not an HTTP request.")
                let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Not an HTTP request message", comment: "")]
                let error = NSError(domain: NSCocoaErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: userInfo)
                if let delegate = self.delegate{delegate.networkConnection(self, didFailWithError: error)}
                return
            }
            var jsonData: Any?
            if data != nil && data!.count > 0 {
                do {
                    jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                } catch {
                    print("Unable to parse json.")
                    let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Unable to parse response message", comment: "")]
                    let error = NSError(domain: NSCocoaErrorDomain, code: NSURLErrorCannotParseResponse, userInfo: userInfo)
                    if let delegate = self.delegate{delegate.networkConnection(self, didFailWithError: error)}
                    return
                }
            }
            
            if let delegate = self.delegate{delegate.networkConnection(self, didSucceedWithResult: jsonData as AnyObject?)}
        }
        currentTask = task
        task.resume()
    }
}

