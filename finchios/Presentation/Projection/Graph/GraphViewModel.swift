//
//  GraphViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import Foundation
import Charts
import OpenAPIClient

class GraphViewModel: ObservableObject, Identifiable {
    
    @Published var timeseries: [ChartDataEntry] = []
    
    
    // Fetch timeseries from backend
    func onAppear() -> ChartDataEntry {
        timeseries = [
            ChartDataEntry(x: 0, y: 10),
            ChartDataEntry(x: 1, y: 5),
            ChartDataEntry(x: 2, y: 0),
            ChartDataEntry(x: 3, y: 0),
            ChartDataEntry(x: 4, y: 100),
            ChartDataEntry(x: 5, y: 200),
        ]
//        TimeseriesAPI.getTimeseries { (result, error) in
//            DispatchQueue.main.async {
//                if let error = error {
//                    // Failure, notify user
//                    print(error)
//                }else {
//                    // Success
//                    guard let result = result else {
//                        // Failure, notify user
//                        return
//                    }
//
//                    self.timeseries = result.series.enumerated().map { (index, value) in
//                        return ChartDataEntry(x: Double(index), y: value)
//                    }
//                }
//            }
//        }
        
        if let last = timeseries.last {
            return last
        }
        return ChartDataEntry(x: 0, y: 0)
    }
    
}
