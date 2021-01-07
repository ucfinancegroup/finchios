//
//  Double.swift
//  finchios
//
//  Created by Brett Fazio on 1/7/21.
//

import Foundation

extension Double {
    
    public init(hundredOffsetInt: Int) {
        let convert = Double(hundredOffsetInt)
        
        self.init(convert / 100)
    }
    
}
