//
//  ChangeFinancialsModel.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import Foundation
import OpenAPIClient

class ChangeFinancialsModel: ObservableObject, Identifiable {
    
    enum ChangeFinAlertType {
        case invalid, empty, success, server
    }
    
    @Published var income: String
    
    @Published var showAlert: Bool = false
    @Published var type: ChangeFinAlertType = .invalid
    
    init() {
        //TODO(): Fill in w their original personal info

        self.income = "0"
        
        UserService.get { (_, _, user) in
            DispatchQueue.main.async {
                if let user = user {
                    self.income = "\(user.income)"
                }
                
            }
        }
    }
    
    func changedTapped() {
        print(income)
        if income.count == 0 {
            type = .empty
            showAlert = true
            return
        }
        
        let parsedIncome: Double
        if let parse = Double(self.income) {
            parsedIncome = parse
        }else {
            type = .invalid
            showAlert = true
            return
        }
        
        let updateFinPayload = UpdateUserRequest(password: nil, firstName: nil, lastName: nil, income: parsedIncome)
        
        UserService.update(payload: updateFinPayload) { (success, _, user) in
            DispatchQueue.main.async {
                if let _ = user {
                    self.type = .success
                    
                }else {
                    self.type = .server
                }
                self.showAlert = true
            }
        }
    }
    
}
