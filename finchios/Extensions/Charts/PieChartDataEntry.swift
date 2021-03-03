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
        //TODO() Don't force unwrap
        self.init(value: alloc.proportion!, label: alloc.asset.name)
    }
    
}
