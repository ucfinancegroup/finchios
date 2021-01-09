//
//  Goal.swift
//  finchios
//
//  Created by Brett Fazio on 1/1/21.
//

import Foundation
import OpenAPIClient

extension Goal {
    
    static let dummy: Goal = Goal(id: MongoObjectID(oid: "ffff"),
                                  name: "Personal Savings Goal",
                                  period: TimePeriod(start: 0, end: 50),
                                  threshold: 500,
                                  goalSide: .above,
                                  completed: false,
                                  feasible: nil)
    
}
