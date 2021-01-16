//
//  RecurringEditViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 1/15/21.
//

import SwiftUI
import OpenAPIClient

class RecurringEditViewModel: ObservableObject, Identifiable {
    
    @Published var showAlert: Bool = false
    @Published var success: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorString: String = ""

    // Fields
    @Published var name: String = ""
    
    @Published var start: Date = Date()
    @Published var end: Date = Date()
    
    @Published var amountField: String = ""
    
    @Published var principalField: String = ""
    @Published var interestField: String = ""
    
    @Published var typ: RecurringIntervalType = .monthly
    @Published var freqContentField: String = "1"
    
    
    func setOnAppear(recurring: Recurring) {
        name = recurring.name
        
        start = Date(timeIntervalSince1970: TimeInterval(recurring.start))
        end = Date(timeIntervalSince1970: TimeInterval(recurring.start))
        
        amountField = "\(recurring.amount)"

        principalField = "\(recurring.principal)"
        
        interestField = "\(recurring.interest)"
        
        switch (recurring.frequency.typ) {
        case .annually:
            typ = .annually
            break
        case .monthly:
            typ = .monthly
            break
        case .weekly:
            typ = .weekly
            break
        case .daily:
            typ = .daily
            break
        }
        
        freqContentField = "\(recurring.frequency.content)"
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
    
    func edit(id: String) {
        showError = false
        success = false
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
        
        var amount: Int64 = 0
        var principal: Int64 = 0
        var interest: Double = 0.0
        
        // Assume this is a debt object
        if incomeEmpty() {
            // Attempt to parse the principal and interest.
            
            if let parse = Double(principalField) {
                principal = Int64(parse * 100)
            }else {
                showAlert = true
                showError = true
                errorString = "Failed to parse the principal. Please ensure it is a valid number."
                return
            }
            
            if let parse = Double(interestField) {
                interest = parse / 100.0
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
                amount = Int64(parse * 100)
            }else {
                showAlert = true
                showError = true
                errorString = "Failed to parse the amount. Please ensure it is a valid number."
                return
            }
        }
        
        //TODO(): Fill in and then test whole method.
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
        
        let payload = RecurringNewPayload(name: name,
                                          start: Int64(start.timeIntervalSince1970),
                                          end: Int64(start.timeIntervalSince1970),
                                          principal: principal,
                                          amount: amount,
                                          interest: interest,
                                          frequency: timeInterval)
        
        RecurringService.updateRecurring(id: id, payload: payload) { (success, error, result) in
            DispatchQueue.main.async {
                self.resetAlertVars()
                
                
                if success {
                    self.success = true
                }else {
                    self.showError = true
                    if let error = error {
                        self.errorString = "\(error)"
                    }
                }
                
                self.showAlert = true
            }
        }
        
    }
    
    func resetAlertVars() {
        showAlert = false
        success = false
        showError = false
        errorString = ""
    }

}
