//
//  RecurringViewState.swift
//  finchios
//
//  Created by Brett Fazio on 1/8/21.
//

import SwiftUI
import OpenAPIClient

class RecurringViewState: ObservableObject, Identifiable {
    
    @Binding var type: RecurringItemType
    
    @Published var recurrings: [RecurringIdentifiable] = []
    
    init(type: Binding<RecurringItemType>) {
        _type = type
    }
    
    func onAppear(time: OverviewProjection) {
        
        let service: RecurringProtocol.Type
        switch time {
        case .overview:
            service = RecurringService.self
        case .projection:
            service = PlansService.self
        }
        
        if type == .expense {
            service.expenses { (success, error, result) in
                DispatchQueue.main.async {
                    if let result = result {
                        self.recurrings = result.map { RecurringIdentifiable(recurring: $0) }
                    }
                }
            }
        }

        else if type == .income {
            service.incomes { (success, error, result) in
                DispatchQueue.main.async {
                    if let result = result {
                        self.recurrings = result.map { RecurringIdentifiable(recurring: $0) }
                    }
                }
            }
        }
        
        
        else if type == .debt {
            service.debt { (success, error, result) in
                DispatchQueue.main.async {
                    if let result = result {
                        self.recurrings = result.map { RecurringIdentifiable(recurring: $0) }
                    }
                }
            }
        }
        
    }
    
}

