//
//  AllocationModel.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import Foundation
import OpenAPIClient

class AllocationModel: ObservableObject, Identifiable {
    
    @Published var allocations: [Iden<Allocation>] = []
    
    func onAppear() {
        PlansService.allocations { (_, _, result) in
            DispatchQueue.main.async {
                if let result = result {
                    self.allocations = result.map { Iden<Allocation>(obj: $0) }
                }
            }
        }
    }
    
}
