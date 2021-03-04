//
//  NewAllocationModel.swift
//  finchios
//
//  Created by Brett Fazio on 3/4/21.
//

import Foundation
import OpenAPIClient

class NewAllocationModel: ObservableObject, Identifiable {
    
    // Fields
    @Published var title: String = ""
    @Published var date: Date = Date()
    
    // Alerts
    @Published var showAlert: Bool = false
    
    @Published var showError: Bool = false
    var errorString: String = ""
    
    @Published var showSuccess: Bool = false
    
    func getSum() -> Int {
        return 0
    }
    
    func getAllocationObject() -> Allocation? {
        return nil
    }
    
    func create() {
        
    }
    
}
