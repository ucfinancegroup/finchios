//
//  GoalSummaryViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation
import OpenAPIClient

class GoalSummaryViewModel: ObservableObject, Identifiable {
    
    @Published var goals: [Goal] = []
    
    func fetch() {
        
    }
    
}
