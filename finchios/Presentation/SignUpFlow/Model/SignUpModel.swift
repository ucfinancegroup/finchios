//
//  SignUpView.swift
//  finchios
//
//  Created by Brett Fazio on 8/23/20.
//  Copyright © 2020 Brett Fazio. All rights reserved.
//

import Foundation
import Combine

class SignUpModel: ObservableObject, Identifiable {

    // Input data
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var name: String = ""

    // For account creation success/failure
    @Published var accountCreated: Bool = false
    @Published var creationFailed: Bool = false
    @Published var creationErrorType: CreationErrorType = .signUp

    // For name input success/failure (SignUpNameView)
    @Published var nameValid: Bool = false
    @Published var nameError: Bool = false
    
    // For email input success/failure (SignUpEmailView)
    @Published var emailError: Bool = false
    @Published var emailValid: Bool = false

    // For username input success/failure (SignUpUsernameView)
    @Published var usernameValid: Bool = false
    @Published var usernameError: Bool = false


    // For code activation success/failure
    @Published var activateError: Bool = false

    func getName() -> (first: String, last: String) {
        let split = name.split(separator: " ")
        
        if split.count == 1 {
            return (first: String(split[0]), last: "")
        }
        
        return (first: String(split[0]), last: String(split[1]))
    }
    
    // Try to perform user sign up.
    func createAccount() {
        let (first, last) = getName()
        
        SignUpService.signUp(email: email, firstName: first, lastName: last, password: password) { (success, error, response) in
            if success {
                
            }
        }
    }
    
    func validateName() {
        if self.name.isEmpty {
            self.nameValid = false
            self.nameError = true
            return
        }
        
        self.nameValid = true
        self.nameError = false
    }

    func validateEmail() {
        self.emailError = false
        self.emailValid = true
        // TODO(): Make sure the email is a real email (format)

        // Make sure it is available
//        AuthAvailableService.emailAvailable(email: email) { (result) in
//            DispatchQueue.main.async {
//                if result {
//                    // is available
//                    self.emailError = false
//                    self.emailValid = true
//                } else {
//                    // not available
//                    self.emailError = true
//                    self.emailValid = false
//                }
//            }
//        }
    }

    func validatePassword() -> Bool {
        let matching = password == confirmPassword

        // TODO(): Also make sure it is complex enough

        return matching
    }


    func onAppear() {
    }

    func onDisappaer() {
    }

}

enum CreationErrorType {
    case signUp, activate
}
