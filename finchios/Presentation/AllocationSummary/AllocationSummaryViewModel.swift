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
                    
                    let cutoff = PieChartDataEntry.cutoff
                    
                    self.allocationConfiguration = first.schema.map { PieChartDataEntry(alloc: $0) }
                    
                    let smalls = self.allocationConfiguration.filter({ $0.value < Double(cutoff) })
                    
                    self.allocationConfiguration.removeAll { $0.value < Double(cutoff) }
                    
                    if smalls.count > 0 {
                        let sum = smalls.map({$0.value}).reduce(0, +)
                        
                        self.allocationConfiguration.append( PieChartDataEntry(value: sum, label: "Other") )
                    }
                }
            }
        }
    }
    
}
