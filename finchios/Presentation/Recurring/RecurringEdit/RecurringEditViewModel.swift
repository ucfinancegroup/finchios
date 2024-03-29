//
//  RecurringEditViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 1/15/21.
//

import SwiftUI
import OpenAPIClient

public class RecurringEditViewModel: ObservableObject, Identifiable {
    
    @Published var showAlert: Bool = false
    @Published var success: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorString: String = ""

    // Fields
    @Published public var name: String
    
    @Published public var start: Date
    @Published public var end: Date
    
    @Published public var amountField: String
    
    @Published public var principalField: String
    @Published public var interestField: String
    
    @Published public var typ: RecurringIntervalType
    @Published public var freqContentField: String
    
    public final var types: [Iden<RecurringIntervalType>] = RecurringIntervalType.allCases.map { Iden<RecurringIntervalType>(obj: $0) }
    
    public init() {
        name = ""
        start = Date()
        end = Date()
        amountField = ""
        principalField = ""
        interestField = ""
        typ = .annually
        freqContentField = ""
    }
    
    public func convertTo(og: RecurringIntervalType) -> String {
        switch og {
        case .annually:
            return "year(s)"
        case .daily:
            return "day(s)"
        case .monthly:
            return "month(s)"
        case .weekly:
            return "week(s)"
        }
    }
    
    public func set(recurring: Recurring) {
        name = recurring.name
        
        start = Date(timeIntervalSince1970: TimeInterval(recurring.start))
        end = Date(timeIntervalSince1970: TimeInterval(recurring.end))
        
        if recurring.principal == 0 {
            amountField = "\(abs((recurring.amount)))"
            
            principalField = ""
            interestField = ""
        }else {
            principalField = "\(abs(Int(recurring.principal)))"
            
            interestField = "\(recurring.interest)"
            
            amountField = ""
        }
        
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
    
    func edit(id: String, time: OverviewProjection, type: RecurringItemType) {
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
        
        let service: RecurringProtocol.Type
        switch time {
        case .overview:
            service = RecurringService.self
        case .projection:
            service = PlansService.self
        }
        
        service.updateRecurring(id: id, payload: payload) { (success, error, result, plan) in
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
    
    public func createPropObj(original: Recurring, type: RecurringItemType) -> Recurring {
        // Should NEVER occur is due to pre conditions of when this function is called.
        var amount: Double = 0.0
        var principal: Double = 0.0
        var interest: Double = 0.0
        
        var content: Int = 0
        
        if let parse = Int(freqContentField) {
            content = parse
        }else {
            // Should NEVER occur
        }
        
        // Assume this is a debt object
        if incomeEmpty() {
            // Attempt to parse the principal and interest.
            
            if let parse = Double(principalField) {
                principal = parse
            }else {
                // Should NEVER occur
            }
            
            if let parse = Double(interestField) {
                interest = parse
            }else {
                // Should NEVER occur
            }
        }
        
        // Assume this is an amount object
        if debtEmpty() {
            // Attempt to parse the amount
            
            if let parse = Double(amountField) {
                amount = parse
            }else {
                // Should NEVER occur
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
        
        // If expense or debt, make negative
        if type == .debt {
            principal *= -1
        }
        if type == .expense {
            amount *= -1
        }
        
        let recurring = Recurring(id: original.id,
                                  name: self.name,
                                  start: Int64(self.start.timeIntervalSince1970),
                                  end: Int64(self.end.timeIntervalSince1970),
                                  principal: principal,
                                  amount: amount,
                                  interest: interest,
                                  frequency: timeInterval)
        
        return recurring
    }
    
    public func resetAlertVars() {
        showAlert = false
        success = false
        //showError = false
        errorString = ""
    }

}
