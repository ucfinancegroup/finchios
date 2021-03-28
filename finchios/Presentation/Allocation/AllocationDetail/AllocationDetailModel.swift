//
//  AllocationDetailModel.swift
//  finchios
//
//  Created by Brett Fazio on 3/1/21.
//

import Foundation
import OpenAPIClient
import Charts

class AllocationDetailModel: ObservableObject, Identifiable {
    
    @Published var allocationConfiguration: [PieChartDataEntry] = [PieChartDataEntry(value: 1)]
    
    @Published var showAlert: Bool = false
    
    @Published var success: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorString: String = ""
    
    func setup(alloc: Allocation) {
        allocationConfiguration = AllocationDetailModel.getConfig(alloc: alloc)
        
        let cutoff = PieChartDataEntry.cutoff
        
        let smalls = self.allocationConfiguration.filter({ $0.value < Double(cutoff) })
        
        self.allocationConfiguration.removeAll { $0.value < Double(cutoff) }
        
        if smalls.count > 0 {
            let sum = smalls.map({$0.value}).reduce(0, +)
            
            self.allocationConfiguration.append( PieChartDataEntry(value: sum, label: "Other") )
        }
    }
    
    static func getConfig(alloc: Allocation) -> [PieChartDataEntry] {
        return alloc.schema.map { PieChartDataEntry(alloc: $0) }
    }
    
    func delete(id: String) {
        
        PlansService.deleteAllocation(id: id) { (success, error, _, response) in
            DispatchQueue.main.async {
                self.success = false
                self.showError = false
                self.errorString = ""
                
                if success {
                    self.success = true
                }else {
                    self.showError = true
                    if let error = error {
                        self.errorString = "\(error)"
                    }
                }
                
                self.showAlert = true
            }
        }
        
    }
    
}
