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
    
    static func formatOffset(amt: Double) -> String {
        return format(amt: Double(hundredOffsetInt: Int(amt)))
    }
    
    static func formatOffset(amt: Int64) -> String {
        return format(amt: Double(hundredOffsetInt: Int(amt)))
    }
    
    static func format(amt: Double) -> String {
        return "\(String(format:"%.02f", amt))"
    }
    
    public func format() -> String {
        return Double.format(amt: self)
    }
    
}
