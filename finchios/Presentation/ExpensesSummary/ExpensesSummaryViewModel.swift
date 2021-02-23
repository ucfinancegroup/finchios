//
//  ExpensesSummaryViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation
import OpenAPIClient

class ExpensesSummaryViewModel: ObservableObject, Identifiable {
    
    @Published var expenses: [Recurring] = []
    
}
