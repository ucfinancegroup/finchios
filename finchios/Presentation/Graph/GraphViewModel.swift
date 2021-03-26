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
    @Published var today: ChartDataEntry = .init(x: 0, y: 0)
        
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
    func onAppear(type: GraphType) {
        TimeSeriesService.get { (succcess, error, response) in
            DispatchQueue.main.async {
                if let response = response {
                    
                    let len = response.series.count
                    
                    let tillToday = response.series.prefix { (entry) -> Bool in
                        return entry.date <= response.start
                    }
                    if type == .overview {
                        self.timeseries = tillToday.map { ChartDataEntry(timeseriesEntry: $0) }
                    }else if type == .projection {
                        
                        // Suffix to get all days in the future AND today
                        self.timeseries = response.series
                            .suffix(len - tillToday.count + 1)
                            .map { ChartDataEntry(timeseriesEntry: $0) }
                        
                        if let first = self.timeseries.first {
                            self.timeseries = self.timeseries.enumerated().compactMap { index, element in index % 30 == 0 ? element : nil }
                            
                            // If i removed today, add it back in
                            if self.timeseries[0].x != first.x {
                                self.timeseries.insert(first, at: 0)
                            }
                        }
                        
                    }
                    
                    // Set today's date
                    if let select = response.series.first(where: { $0.date == response.start }) {
                        self.selected = ChartDataEntry(timeseriesEntry: select)
                        self.today = ChartDataEntry(timeseriesEntry: select)
                    }
                }
            }
        }
    }
    
}
