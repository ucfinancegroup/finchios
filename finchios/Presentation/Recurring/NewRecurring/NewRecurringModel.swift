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
    @Published var end: Date = Date.tomorrow
    
    @Published var amountField: String = ""
    
    @Published var principalField: String = ""
    @Published var interestField: String = ""
    
    //TODO(): need to change this to TimeInterval.Typ to make payload
    @Published var typ: RecurringIntervalType = .monthly
    @Published var freqContentField: String = ""
    
    @Published var showAlert: Bool = false
    
    @Published var showError: Bool = false
    var errorString: String = ""
    
    @Published var showSuccess: Bool = false
    
    // Type
    var type: RecurringItemType
    
    public init(type: RecurringItemType) {
        self.type = type
    }
    
    func create() {
        showError = false
        showSuccess = false
        showAlert = false
        
        // Create a payload and pass it to the service.
        // Just need to ensure all ints / doubles are valid and non-empty.
        
        if incomeEmpty() && debtEmpty() {
            financialInformationNotFilledError()
            return
        }
        
        if freqContentEmpty() {
            showAlert = true
            showError = true
            errorString = "The interval field was unable to be parsed. Please ensure it is a real number."
            return
        }
        
        var content: Int = 0
        
        if let parse = Int(freqContentField) {
            content = parse
        }else {
            showAlert = true
            showError = true
            errorString = "Failed to parse the interval field. Please ensure it is a valid number."
            return
        }
        
        var amount: Double = 0.0
        var principal: Double = 0.0
        var interest: Double = 0.0
        
        // Assume this is a debt object
        if incomeEmpty() {
            // Attempt to parse the principal and interest.
            
            if let parse = Double(principalField) {
                principal = parse
            }else {
                showAlert = true
                showError = true
                errorString = "Failed to parse the principal. Please ensure it is a valid number."
                return
            }
            
            if let parse = Double(interestField) {
                interest = parse
            }else {
                showAlert = true
                showError = true
                errorString = "Failed to parse the interest. Please ensure it is a valid number."
                return
            }
        }
        
        // Assume this is an amount object
        if debtEmpty() {
            // Attempt to parse the amount
            
            if let parse = Double(amountField) {
                amount = parse
            }else {
                showAlert = true
                showError = true
                errorString = "Failed to parse the amount. Please ensure it is a valid number."
                return
            }
        }
        
        if start >= end {
            showError = true
            errorString = "The starting date must be prior to the ending date."
            showAlert = true
            return
        }
        
        var timeInterval = TimeInterval(typ: .monthly, content: content)
        switch typ {
        case .annually:
            timeInterval.typ = .annually
        case .monthly:
            timeInterval.typ = .monthly
        case .weekly:
            timeInterval.typ = .weekly
        case .daily:
            timeInterval.typ = .daily
        }
        
        // If expense or debt, make negative
        if type == .debt {
            principal *= -1
        }
        if type == .expense {
            amount *= -1
        }
        
        
        let payload = RecurringNewPayload(name: name,
                                          start: Int64(start.timeIntervalSince1970),
                                          end: Int64(end.timeIntervalSince1970),
                                          principal: principal,
                                          amount: amount,
                                          interest: interest,
                                          frequency: timeInterval)
        
        RecurringService.newRecurring(payload: payload) { (success, error, _) in
            DispatchQueue.main.async {
                self.errorString = ""
                
                if success {
                    // show a success alert and then from there set the presentation bool to false.
                    self.showSuccess = true
                    self.showAlert = true
                }else {
                    if let error = error {
                        self.errorString = "\(error)"
                    }
                    self.showError = true
                    self.showAlert = true
                }
            }

        }
        
    }
    
    private func financialInformationNotFilledError() {
        showAlert = true
        showError = true
        errorString = "You did not fill out the financial information (amount or principal)."
    }
    
    private func incomeEmpty() -> Bool {
        return self.amountField.count == 0
    }
    
    private func debtEmpty() -> Bool {
        return self.principalField.count == 0 && self.interestField.count == 0
    }
    
    private func freqContentEmpty() -> Bool {
        return self.freqContentField.count == 0
    }
}
