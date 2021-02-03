//
//  ChartDataEntry.swift
//  finchios
//
//  Created by Brett Fazio on 2/3/21.
//

import Foundation
import Charts
import OpenAPIClient

extension ChartDataEntry {
    
    public convenience init(timeseriesEntry: TimeSeriesEntry) {
        self.init(x: Double(timeseriesEntry.date), y: timeseriesEntry.netWorth.amount)
    }
    
    static let dummySeries = [
        ChartDataEntry(x: 0, y: 10),
        ChartDataEntry(x: 1, y: 5),
        ChartDataEntry(x: 2, y: 0),
        ChartDataEntry(x: 3, y: 0),
        ChartDataEntry(x: 4, y: 100),
        ChartDataEntry(x: 5, y: 200),
    ]
    
    static let dummy = ChartDataEntry(x: 0, y: 0)
    
}
