//
//  Recurring.swift
//  finchios
//
//  Created by Brett Fazio on 1/7/21.
//

import Foundation
import OpenAPIClient

extension Recurring {
    
    static let dummyIncome: Recurring = Recurring(id: MongoObjectID(oid: "ffff"),
                                                  name: "job",
                                                  start: 0,
                                                  end: 50000,
                                                  principal: 0,
                                                  amount: 50,
                                                  interest: 0,
                                                  frequency: TimeInterval(typ: .monthly, content: 5))

}

struct RecurringIdentifiable: Identifiable {
    var id = UUID()
    
    var recurring: Recurring
    
    init(recurring: Recurring) {
        self.recurring = recurring
    }
}

struct FormatTyp {
    static let map: [String: String] = ["monthly" : "month",
        "annually" : "year",
        "daily" : "day",
        "weekly" : "week" ]
}
