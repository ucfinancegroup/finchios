//
//  RecurringSummaryViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import Foundation
import OpenAPIClient

class RecurringSummaryViewModel: ObservableObject, Identifiable {
    
    @Published var incomes: [Recurring] = []
    @Published var expenses: [Recurring] = []
    
    // Fetch subset of recurrings
    func onAppear() {
        
        RecurringService.incomes { (success, error, result) in
            guard let result = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.incomes = Array(result.prefix(3))
            }
        }
        
        RecurringService.expenses { (success, error, result) in
            guard let result = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.expenses = Array(result.prefix(3))
            }
        }
    }
    
}
