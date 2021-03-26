//
//  RecurringSummaryViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import Foundation
import OpenAPIClient

class RecurringSummaryViewModel: ObservableObject, Identifiable {
    
    @Published var incomes: [Iden<Recurring>] = []
    @Published var expenses: [Iden<Recurring>] = []
    @Published var debts: [Iden<Recurring>] = []
    
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
                self.incomes = Array(result.prefix(3).map { Iden<Recurring>(obj: $0)})
            }
        }
        
        service.expenses { (success, error, result) in
            guard let result = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.expenses = Array(result.prefix(3).map { Iden<Recurring>(obj: $0)})
            }
        }
        
        service.debt { (success, error, result) in
            guard let result = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.debts = Array(result.prefix(3).map { Iden<Recurring>(obj: $0)})
            }
        }
    }
    
}
