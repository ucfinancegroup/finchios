//
//  SignUpView.swift
//  finchios
//
//  Created by Brett Fazio on 8/23/20.
//  Copyright © 2020 Brett Fazio. All rights reserved.
//

import Foundation
import Combine
import OpenAPIClient

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
        
        let payload = SignupPayload(email: email, password: password, firstName: first, lastName: last, income: 0.0)
        
        OpenAPIClient.UserAPI.signupUser(signupPayload: payload) { (response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    // handle
                    self.creationFailed = true
                }else {
                    self.accountCreated = true
                    self.creationFailed = false
                }
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
