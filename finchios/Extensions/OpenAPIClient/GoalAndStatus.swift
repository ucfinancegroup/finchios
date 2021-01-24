//
//  GoalAndStatus.swift
//  finchios
//
//  Created by Brett Fazio on 1/15/21.
//

import Foundation
import OpenAPIClient

public extension GoalAndStatus {
    
    static let dummy: GoalAndStatus = GoalAndStatus(goal: Goal.dummy, progress: 0.5)
    
}

public struct GoalAndStatusIdentifiable: Identifiable {
    public var id = UUID()
    
    public var goalAndStatus: GoalAndStatus
}
