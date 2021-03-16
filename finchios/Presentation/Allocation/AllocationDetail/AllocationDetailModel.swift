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
    
    func setup(alloc: Allocation) {
        allocationConfiguration = AllocationDetailModel.getConfig(alloc: alloc)
    }
    
    static func getConfig(alloc: Allocation) -> [PieChartDataEntry] {
        return alloc.schema.map { PieChartDataEntry(alloc: $0) }
    }
    
    func delete(id: String) {
        
        PlansService.deleteAllocation(id: id) { (success, _, _, response) in
            DispatchQueue.main.async {
                
            }
        }
        
    }
    
}
