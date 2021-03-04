//
//  PieChartDataEntry.swift
//  finchios
//
//  Created by Brett Fazio on 2/23/21.
//

import Foundation
import Charts
import OpenAPIClient

public extension PieChartDataEntry {
    
    convenience init(alloc: AllocationProportion) {
        self.init(value: alloc.proportion, label: alloc.asset.name)
    }
    
}
