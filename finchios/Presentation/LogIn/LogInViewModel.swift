//
//  LogInViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 8/21/20.
//  Copyright © 2020 Brett Fazio. All rights reserved.
//

import Foundation
import Combine

class LogInViewModel: ObservableObject, Identifiable {

    @Published var email: String = ""
    @Published var password: String = ""

    @Published var logInSuccess: Bool = false
    
    @Published var showAlert: Bool = false
    @Published var logInError: Bool = false
    @Published var errorStr: String = "Unidentified"

    var trying: Bool = false
    
    // Try to perform user log-in.
    func logInTapped() {
        if trying {
            return
        }
        
        trying = true
        LogInService.logIn(email: email, password: password) { (success, error, _) in
            DispatchQueue.main.async {
                if success {
                    // login success
                    self.logInSuccess = true
                    self.logInError = false
                } else {
                    // login failed
                    self.logInSuccess = false
                    self.logInError = true
                    if let error = error {
                        self.errorStr = "\(error)"
                    }
                }
                self.showAlert = true
                self.trying = false
            }
        }
    }
}
