//
//  ChangePasswordModel.swift
//  finchios
//
//  Created by Brett Fazio on 2/24/21.
//

import Foundation
import OpenAPIClient

class ChangePasswordModel: ObservableObject, Identifiable {
    
    enum ChangePasswordAlertType {
        case notEqual, success, server
    }
    
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var showAlert: Bool = false
    @Published var type: ChangePasswordAlertType = .notEqual
    
    func changedTapped() {
        if newPassword != confirmPassword && newPassword.count >= 8 {
            type = .notEqual
            showAlert = true
            return
        }
        
        let updatePassPayload = UpdateUserRequest(password: newPassword, firstName: nil, lastName: nil, income: nil)
        
        UserService.update(payload: updatePassPayload) { (success, _, user) in
            DispatchQueue.main.async {
                if let _ = user {
                    self.type = .success
                    
                    let cacheJWT = CredentialsObject.shared.jwt
                    let cacheEmail = CredentialsObject.shared.email
                    
                    _ = CredentialsObject.resetCredentials(jwt: cacheJWT, email: cacheEmail, password: self.newPassword)
                }else {
                    self.type = .server
                }
                self.showAlert = true
            }
        }
    }
    
}
