//
//  Recurring.swift
//  finchios
//
//  Created by Brett Fazio on 1/7/21.
//

import Foundation
import OpenAPIClient

extension Recurring {
    
    static let dummyIncome: Recurring = Recurring(id: "ffff",
                                            name: "job",
                                            start: 0,
                                            end: 50000,
                                            principal: 0,
                                            amount: 50,
                                            interest: 0,
                                            amountFreq: TimeInterval(typ: .monthly, content: 5),
                                            interestFreq: TimeInterval(typ: .monthly, content: 0),
                                            contributionFreq: TimeInterval(typ: .monthly, content: 0))
    
}
