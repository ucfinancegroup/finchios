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
    @Published var debts: [Recurring] = []
    
    // Fetch subset of recurrings
    func onAppear(type: OverviewProjection) {
        
        let service: RecurringProtocol.Type
        switch type {
        case .overview:
            service = RecurringService.self
        case .projection:
            service = PlansService.self
        }
        
        service.incomes { (success, error, result) in
            guard let result = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.incomes = Array(result.prefix(3))
            }
        }
        
        service.expenses { (success, error, result) in
            guard let result = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.expenses = Array(result.prefix(3))
            }
        }
        
        service.debt { (success, error, result) in
            guard let result = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.debts = Array(result.prefix(3))
            }
        }
    }
    
}
