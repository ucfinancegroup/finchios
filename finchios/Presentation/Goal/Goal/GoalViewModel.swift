//
//  GoalViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 1/16/21.
//

import Foundation

class GoalViewModel: ObservableObject, Identifiable {
    
    @Published var goals: [GoalAndStatusIdentifiable] = []
    
    func onAppear() {
        
        GoalsService.goals { (success, error, result) in
            DispatchQueue.main.async {
                if let result = result {
                    self.goals = result.map { GoalAndStatusIdentifiable(goalAndStatus: $0) }
                }
            }
        }
        
    }
    
}
