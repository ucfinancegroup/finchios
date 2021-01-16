//
//  GoalSummaryViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation
import OpenAPIClient

class GoalSummaryViewModel: ObservableObject, Identifiable {
    
    @Published var goals: [GoalAndStatus] = []
    
    func fetch() {
        GoalsService.goals { (success, error, result) in
            DispatchQueue.main.async {
                if success {
                    if let result = result {
                        self.goals = result
                    }
                }else {
                    //Error
                }
            }
        }
    }
    
}
