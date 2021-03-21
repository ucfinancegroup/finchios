//
//  RecurringIntervalType.swift
//  finchios
//
//  Created by Brett Fazio on 1/11/21.
//

import OpenAPIClient

public enum RecurringIntervalType: String, CaseIterable {
    public var id: RecurringIntervalType { self }
    
    case monthly = "monthly"
    case annually = "annually"
    case daily = "daily"
    case weekly = "weekly"
    
    public static func from(_ og: TimeInterval.Typ) -> RecurringIntervalType {
        switch og {
        case .annually:
            return .annually
        case .monthly:
            return .monthly
        case .daily:
            return .daily
        case .weekly:
            return .weekly
        }
    }
}
