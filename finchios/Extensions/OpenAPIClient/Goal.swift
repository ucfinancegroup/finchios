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
                                  start: 5000,
                                  end: 6000,
                                  threshold: 5000,
                                  metric: .savings)
    
}
