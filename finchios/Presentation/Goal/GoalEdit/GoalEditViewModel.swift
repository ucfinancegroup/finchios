//
//  GoalEditViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 1/18/21.
//

import Foundation
import OpenAPIClient

public class GoalEditViewModel: ObservableObject, Identifiable {
    
    @Published public var showAlert: Bool = false
    @Published public var alertType: SuccessFail = .success
    @Published public var errorDetail: String = ""
    
    // Fields
    @Published public var name: String = ""
    @Published public var start: Date = Date()
    @Published public var end: Date = Date()
    @Published public var threshold: String = ""
    @Published public var metric: GoalMetricIdentifiable = .savings
    
    private var updator: GoalAndStatus?
    
    // Override to make public
    public init() { }
    
    public func set(goal: GoalAndStatus) {
        
        name = goal.goal.name
        start = Date(timeIntervalSince1970: TimeInterval(goal.goal.start))
        end = Date(timeIntervalSince1970: TimeInterval(goal.goal.end))
        
        threshold = "\(goal.goal.threshold)"
        
        switch goal.goal.metric {
        case .income:
            metric = .income
            break
        case .savings:
            metric = .savings
            break
        case .spending:
            metric = .spending
            break
        }
        
    }
    
    public func getGoal(goal: GoalAndStatus) -> GoalAndStatus {
        // Assume all fields are valid
        
        if let update = updator {
            return update
        }
        return goal
    }
    
    public func getPayload() -> GoalNewPayload? {
        showAlert = false
        errorDetail = ""
        
        // Create a payload and pass it to the service.
        // Just need to ensure all ints / doubles are valid and non-empty.
        
        if name.count == 0 {
            alertType = .fail
            errorDetail = "The name must be non-empty."
            showAlert = true
            return nil
        }
        
        if threshold.count == 0 {
            alertType = .fail
            errorDetail = "The threshold field must be non-empty."
            showAlert = true
            return nil
        }
        
        var thresholdParse: Double = 0
        
        if let parse = Double(threshold) {
            thresholdParse = parse
        }else {
            alertType = .fail
            errorDetail = "Failed to parse the threshold field. Please ensure it is a valid number."
            showAlert = true
            return nil
        }
        
        if start >= end {
            alertType = .fail
            errorDetail = "The starting date must be strictly prior to the ending date."
            showAlert = true
            return nil
        }
        
        let payload: GoalNewPayload = GoalNewPayload(name: name,
                                                     start: Int64(start.timeIntervalSince1970),
                                                     end: Int64(end.timeIntervalSince1970),
                                                     threshold: thresholdParse,
                                                     metric: metric.openAPI)
        
        return payload
    }
    
    public func edit(id: String) {

        let payload = getPayload()
        
        if let payload = payload {
            GoalsService.updateGoal(id: id, payload: payload) { (success, error, result) in
                DispatchQueue.main.async {
                    self.updator = result
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
    
}
