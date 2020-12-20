//
//  AllocationViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import Foundation
import Charts

class AllocationSummaryViewModel: ObservableObject, Identifiable {
    
    @Published var allocationConfiguration: [PieChartDataEntry] = []
    
    // Fetch allocation config
    func onAppear() {
        
    }
    
}
