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
                                    AllocationProportion(asset: .init(name: "Stock", _class: .init(typ: .equity, content: "Stock")), proportion: 50),
                                    AllocationProportion(asset: .init(name: "Bond", _class: .init(typ: .fixed, content: "Bond")), proportion: 20),
                                    AllocationProportion(asset: .init(name: "Cash", _class: .init(typ: .cash, content: "Cash")), proportion: 30)])
    
}
