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
    
    func onAppear() {
        
        switch type {
        case .expense:
            RecurringService.expenses { (success, error, result) in
                DispatchQueue.main.async {
                    if let result = result {
                        self.recurrings = result.map { RecurringIdentifiable(recurring: $0) }
                    }
                }
            }
            break
        case .income:
            RecurringService.incomes { (success, error, result) in
                DispatchQueue.main.async {
                    if let result = result {
                        self.recurrings = result.map { RecurringIdentifiable(recurring: $0) }
                    }
                }
            }
            break
        case .debt:
            RecurringService.debt { (success, error, result) in
                DispatchQueue.main.async {
                    if let result = result {
                        self.recurrings = result.map { RecurringIdentifiable(recurring: $0) }
                    }
                }
            }
            break
        }
        
    }
    
}

