//
//  AllocationViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import Foundation
import Charts

class AllocationSummaryViewModel: ObservableObject, Identifiable {
    
    @Published var allocationConfiguration: [PieChartDataEntry] = [PieChartDataEntry(value: 1)]
    
    // Fetch allocation config
    func onAppear() {
        PlansService.allocations { (success, _, result) in
            DispatchQueue.main.async {
                if let result = result {
                    guard let first = result.first else {
                        return
                    }
                    
                    self.allocationConfiguration = first.schema.map { PieChartDataEntry(alloc: $0) }
                }
            }
        }
    }
    
}
