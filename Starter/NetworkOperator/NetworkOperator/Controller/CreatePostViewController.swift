//
//  CreatePostViewController.swift
//  NetworkOperator
//
//  Created by An Le on 2/5/17.
//  Copyright © 2017 Maniac Mobility. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController, UITextViewDelegate {

    
    //MARK:- IBOutlets
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Body TextView
        bodyTextView.layer.borderWidth = 1
        bodyTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        bodyTextView.text = "Enter Post Body"
        bodyTextView.textColor = UIColor.lightGray
        bodyTextView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            bodyTextView.text = "Enter Post Body"
            bodyTextView.textColor = UIColor.lightGray
        }
        
    }

    @IBAction func didButtonPress(_ sender: UIButton){
        
    }
    
    
    // MARK: - Escaping parameters
    func escapedParameters(_ parameters: [String: Any?]) -> String {
        
        if parameters.isEmpty {
            return ""
        } else {
            
            var keyValuePairs = [String]()
            
            for (key, value) in parameters {
                
                if let  unwrappedValue = value{
                    
                    let stringValue = "\(unwrappedValue)"
                    
                    let escapedValue = stringValue.urlAllowedEncoded
                    
                    if !escapedValue.isEmpty{
                        
                        keyValuePairs.append(key + "=" + "\(escapedValue)")
                    }
                }
            }
            return keyValuePairs.joined(separator: "&")
        }
    }
}
