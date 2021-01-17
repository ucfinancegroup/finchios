//
//  GoalMetricIdentifiable.swift
//  finchios
//
//  Created by Brett Fazio on 1/17/21.
//

import Foundation
import OpenAPIClient

enum GoalMetricIdentifiable: String, CaseIterable {
    
    var id: GoalMetricIdentifiable { self }
    
    case savings = "Savings"
    case spending = "Spending"
    case income = "Income"
    
    var openAPI: GoalMetric {
            get {
                switch self {
                case .savings:
                    return GoalMetric.savings
                case .spending:
                    return GoalMetric.spending
                case .income:
                    return GoalMetric.income
                }
            }
//            set {
//                origin.x = newValue.x - (size.width / 2)
//                origin.y = newValue.y - (size.height / 2)
//            }
        }
}


