//
//  Allocation.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import Foundation
import OpenAPIClient

extension Allocation {
    
    static let dummy = Allocation(description: "My planned 25 year old allocation",
                                  date: 1614570311,
                                  schema: [
                                    AllocationChange(asset: .init(name: "Stock", _class: .init(typ: .equity, content: "Stock")), change: 50),
                                    AllocationChange(asset: .init(name: "Bond", _class: .init(typ: .fixed, content: "Bond")), change: 20),
                                    AllocationChange(asset: .init(name: "Cash", _class: .init(typ: .cash, content: "Cash")), change: 30)])
    
}
