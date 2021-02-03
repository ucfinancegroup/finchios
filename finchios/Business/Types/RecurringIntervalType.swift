//
//  RecurringIntervalType.swift
//  finchios
//
//  Created by Brett Fazio on 1/11/21.
//

import Foundation

public enum RecurringIntervalType: String, CaseIterable {
    public var id: RecurringIntervalType { self }
    
    case monthly = "monthly"
    case annually = "annually"
    case daily = "daily"
    case weekly = "weekly"
}
