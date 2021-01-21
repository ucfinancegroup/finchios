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
        errorDetail = ""
        showAlert = false
        
        // Create a payload and pass it to the service.
        // Just need to ensure all ints / doubles are valid and non-empty.
        
        if name.count == 0 {
            alertType = .fail
            errorDetail = "The name must be non-empty."
            showAlert = true
            return
        }
        
        if threshold.count == 0 {
            alertType = .fail
            errorDetail = "The threshold field must be non-empty."
            showAlert = true
            return
        }
        
        var thresholdParse: Double = 0
        
        if let parse = Double(threshold) {
            thresholdParse = parse
        }else {
            alertType = .fail
            errorDetail = "Failed to parse the threshold field. Please ensure it is a valid number."
            showAlert = true
            return
        }
        
        if start >= end {
            alertType = .fail
            errorDetail = "The starting date must be strictly prior to the ending date."
            showAlert = true
            return
        }

        let payload: GoalNewPayload = GoalNewPayload(name: name,
                                     start: Int64(start.timeIntervalSince1970),
                                     end: Int64(end.timeIntervalSince1970),
                                     threshold: thresholdParse*100,
                                     metric: metric.openAPI)
        
        GoalsService.newGoal(payload: payload) { (success, error, _) in
            DispatchQueue.main.async {
                if success {
                    // show a success alert and then from there set the presentation bool to false.
                    self.alertType = .success
                    self.showAlert = true
                }else {
                    if let error = error {
                        self.errorDetail = "\(error)"
                    }
                    self.alertType = .fail
                    self.showAlert = true
                }
            }

        }
    }
    
}
