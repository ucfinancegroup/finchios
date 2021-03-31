//
//  Double.swift
//  finchios
//
//  Created by Brett Fazio on 1/7/21.
//

import Foundation

public extension Double {

    static func format(amt: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(for: amt) ?? "0.00"//"\(String(format:"%.02f", amt))"
    }
    
    func format() -> String {
        return Double.format(amt: self)
    }
    
}
