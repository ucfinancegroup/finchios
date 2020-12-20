//
//  RecurringSummaryViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import Foundation
import OpenAPIClient

class RecurringSummaryViewModel: ObservableObject, Identifiable {
    
    @Published var recurrings: [Recurring] = []
    
    // Fetch subset of recurrings
    func onAppear() {
        RecurringAPI.getRecurrings { (results, error) in
            DispatchQueue.main.async {
                if let error = error {
                    // Error occured, report to user
                    print(error)
                    return
                }
                
                guard let results = results else {
                    // Error
                    return
                }
                
                self.recurrings = Array(results.prefix(3))
            }
        }
    }
    
}
