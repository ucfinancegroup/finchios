//
//  Double.swift
//  finchios
//
//  Created by Brett Fazio on 1/7/21.
//

import Foundation

extension Double {

    static func format(amt: Double) -> String {
        return "\(String(format:"%.02f", amt))"
    }
    
    public func format() -> String {
        return Double.format(amt: self)
    }
    
}
