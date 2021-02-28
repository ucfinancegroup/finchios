//
//  ChangeNameModel.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import Foundation
import OpenAPIClient

class ChangeNameModel: ObservableObject, Identifiable {
    
    enum ChangeNameAlertType {
        case empty, success, server
    }
    
    @Published var first: String
    @Published var last: String
    
    @Published var showAlert: Bool = false
    @Published var type: ChangeNameAlertType = .empty
    
    init() {
        //TODO(): Fill in w their original personal info
        
        self.first = ""
        self.last = ""
        
        UserService.get { (_, _, user) in
            DispatchQueue.main.async {
                if let user = user {
                    self.first = user.firstName
                    self.last = user.lastName
                }
                
            }
        }
    }
    
    func changedTapped() {
        if first.count == 0 || last.count == 0 {
            type = .empty
            showAlert = true
            return
        }
        
        let updatePassPayload = UpdateUserRequest(password: nil, firstName: first, lastName: last, income: nil)
        
        UserService.update(payload: updatePassPayload) { (success, _, user) in
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
