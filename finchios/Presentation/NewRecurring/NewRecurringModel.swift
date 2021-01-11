//
//  NewRecurringModel.swift
//  finchios
//
//  Created by Brett Fazio on 1/11/21.
//

import Foundation
import OpenAPIClient

class NewRecurringModel: ObservableObject, Identifiable {
    
    @Published var name: String = ""
    
    @Published var start: Date = Date()
    @Published var end: Date = Date()
    
    @Published var amountField: String = ""
    
    @Published var principalField: String = ""
    @Published var interestField: String = ""
    
    @Published var typ: String = "monthly"
    @Published var freqContentField: String = ""
    
    @Published var showError: Bool = false
    var errorString: String = ""
    
    func create() {
        
        // Create a payload and pass it to the service.
        // Just need to ensure all ints / doubles are valid and non-empty.
        
        // TODO(): If the amount is non-empty, fill the principal & interest as 0.
        
        // TODO(): Do the same for amount.
        
        let timeInterval = TimeInterval(typ: .monthly, content: 5)
        
        let payload = RecurringNewPayload(name: name,
                                          start: Int64(start.timeIntervalSince1970),
                                          end: Int64(start.timeIntervalSince1970),
                                          principal: 0,
                                          amount: 0,
                                          interest: 0.0,
                                          frequency: timeInterval)
        
        RecurringService.newRecurring(payload: payload) { (success, error) in
            DispatchQueue.main.async {
                self.errorString = ""
                
                if success {
                    // TODO(): Dismiss
                    // Potentionally show a success alert and then from there set the presentation bool to false.
                }else {
                    if let error = error {
                        self.errorString = "\(error)"
                    }
                    self.showError = true
                }
            }

        }
        
    }
}
