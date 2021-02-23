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
    
    convenience init(alloc: AllocationChange) {
        self.init(value: alloc.change, label: alloc.asset.name)
    }
    
}
