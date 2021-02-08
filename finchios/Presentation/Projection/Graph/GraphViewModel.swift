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
    
    @Published var selected: ChartDataEntry = .dummy
    
    private static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MM/dd/yyyy"
        return f
    }()
    
    func formatDate(timeSince1970: Double) -> String {
        
        let date = Date(timeIntervalSince1970: timeSince1970)
        
        let today = Date()
        
        if Calendar.current.isDate(date, inSameDayAs: today) {
            return "Today"
        }else {
            return GraphViewModel.formatter.string(from: date)
        }
        
    }
    
    // Fetch timeseries from backend
    func onAppear() {
        TimeSeriesService.example { (succcess, error, response) in
            DispatchQueue.main.async {
                if let response = response {
                    self.timeseries = response.map { ChartDataEntry(timeseriesEntry: $0) }
                    
                    if let last = self.timeseries.last {
                        self.selected = last
                    }
                }
            }
        }
    }
    
}
