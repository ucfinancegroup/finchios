//
//  GraphViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import Foundation
import Charts

class GraphViewModel: ObservableObject, Identifiable {
    
    @Published var timeseries: [ChartDataEntry] = []
    
    
    // Fetch timeseries from backend
    func viewDidAppear() {
        
    }
    
}
