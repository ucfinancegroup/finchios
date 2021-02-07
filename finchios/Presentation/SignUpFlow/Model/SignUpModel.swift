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
    @Published var firstName: String = ""
    @Published var lastName: String = ""

    // For account creation success/failure
    @Published var accountCreated: Bool = false
    @Published var creationFailed: Bool = false
    @Published var creationErrorType: CreationErrorType = .signUp
    @Published var creationErrorStr: String = ""

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
    
    // Try to perform user sign up.
    func createAccount() {
        SignUpService.signUp(email: email, firstName: firstName, lastName: lastName, password: password) { (success, error, response) in
            if success {
                self.accountCreated = true
            }else {
                self.accountCreated = false
                self.creationFailed = true
                if let error = error {
                    self.creationErrorStr = "\(error)"
                }
            }
        }
    }
    
    func validateName() {
        if self.firstName.isEmpty || self.lastName.isEmpty {
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
//        ValidateService.validate(payload: ValidateUserPayload(typ: .email, content: email)) { (success, _, _) in
//            DispatchQueue.main.async {
//                if success {
//                    self.emailError = false
//                    self.emailValid = true
//                }else {
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
    case signUp, str
}
