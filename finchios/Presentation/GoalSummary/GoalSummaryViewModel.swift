//
//  GoalSummaryViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation
import OpenAPIClient

class GoalSummaryViewModel: ObservableObject, Identifiable {
    
    @Published var goals: [GoalAndStatusIdentifiable] = []
    
    func fetch() {
        GoalsService.goals { (success, error, result) in
            DispatchQueue.main.async {
                if success {
                    if let result = result {
                        let subsection = Array(result.prefix(3))
                        self.goals = subsection.map { GoalAndStatusIdentifiable(goalAndStatus: $0) }
                    }
                }else {
                    //Error
                }
            }
        }
    }
    
}
