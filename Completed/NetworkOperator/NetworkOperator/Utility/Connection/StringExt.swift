//
//  StringExt.swift
//  NetworkOperator
//
//  Created by An Le on 2/8/17.
//  Copyright © 2017 Maniac Mobility. All rights reserved.
//

import Foundation

extension String {
    var urlAllowedEncoded: String{
        
        let characterSetTobeAllowed = (CharacterSet(charactersIn: "!*'();:@&=+$,/?#[]").inverted)
        
        return self.addingPercentEncoding(withAllowedCharacters: characterSetTobeAllowed) ?? self
        
    }
}
