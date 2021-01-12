//
//  RecurringIntervalType.swift
//  finchios
//
//  Created by Brett Fazio on 1/11/21.
//

import Foundation

enum RecurringIntervalType: String, Codable, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case monthly = "monthly"
    case annually = "annually"
    case daily = "daily"
    case weekly = "weekly"
}
