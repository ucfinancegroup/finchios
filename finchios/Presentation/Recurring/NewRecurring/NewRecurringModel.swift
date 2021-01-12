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
    
    @Published var showSuccess: Bool = false
    
    func create() {
        
        // Create a payload and pass it to the service.
        // Just need to ensure all ints / doubles are valid and non-empty.
        
        if incomeEmpty() && debtEmpty() {
            financialInformationNotFilledError()
            return
        }
        
        var amount: Int64 = 0
        var principal: Int64 = 0
        var interest: Double = 0.0
        
        // Assume this is a debt object
        if incomeEmpty() {
            // Attempt to parse the principal and interest.
            
            if let parse = Double(principalField) {
                principal = Int64(parse * 100)
            }else {
                showError = true
                errorString = "Failed to parse the principal. Please ensure it is a valid number."
                return
            }
            
            if let parse = Double(interestField) {
                interest = parse / 100.0
            }else {
                showError = true
                errorString = "Failed to parse the interest. Please ensure it is a valid number."
                return
            }
        }
        
        // Assume this is an amount object
        if debtEmpty() {
            // Attempt to parse the amount
            
            if let parse = Double(amountField) {
                amount = Int64(parse * 100)
            }else {
                showError = true
                errorString = "Failed to parse the amount. Please ensure it is a valid number."
                return
            }
        }
        
        //TODO(): Fill in and then test whole method.
        let timeInterval = TimeInterval(typ: .monthly, content: 5)
        
        let payload = RecurringNewPayload(name: name,
                                          start: Int64(start.timeIntervalSince1970),
                                          end: Int64(start.timeIntervalSince1970),
                                          principal: principal,
                                          amount: amount,
                                          interest: interest,
                                          frequency: timeInterval)
        
        RecurringService.newRecurring(payload: payload) { (success, error) in
            DispatchQueue.main.async {
                self.errorString = ""
                
                if success {
                    // show a success alert and then from there set the presentation bool to false.
                    self.showSuccess = true
                }else {
                    if let error = error {
                        self.errorString = "\(error)"
                    }
                    self.showError = true
                }
            }

        }
        
    }
    
    private func financialInformationNotFilledError() {
        showError = true
        errorString = "You did not fill out the financial information (amount or principal)."
    }
    
    private func incomeEmpty() -> Bool {
        return self.amountField.count == 0
    }
    
    private func debtEmpty() -> Bool {
        return self.principalField.count == 0 && self.interestField.count == 0
    }
}
