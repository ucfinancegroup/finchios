//
//  NewGoalViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 1/16/21.
//

import Foundation
import OpenAPIClient

class NewGoalViewModel: ObservableObject, Identifiable {
    
    @Published var showAlert: Bool = false
    @Published var alertType: SuccessFail = .success
    @Published var errorDetail: String = ""
    
    // Fields
    @Published var name: String = ""
    @Published var start: Date = Date()
    @Published var end: Date = Date()
    @Published var threshold: String = ""
    @Published var metric: GoalMetricIdentifiable = .savings
    
    func create() {
        
        
        
    }
    
}
