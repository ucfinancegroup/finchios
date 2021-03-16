//
//  AllocationEditModel.swift
//  finchios
//
//  Created by Brett Fazio on 3/4/21.
//

import Foundation
import OpenAPIClient

class AllocationEditModel: ObservableObject, Identifiable {
    
    @Published var showAlert: Bool = false
    @Published var success: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorString: String = ""

    // Fields
    
    
    func set(alloc: Allocation) {
        
    }
    
}
