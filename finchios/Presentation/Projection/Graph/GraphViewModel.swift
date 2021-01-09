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
    func onAppear() {
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
    }
    
}
