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
    @Published var dob: Date = Date()

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
    
    // For DoB input success/failure (SignUpBirthdayView)
    @Published var dobValid: Bool = false
    @Published var dobError: Bool = false


    // For code activation success/failure
    @Published var activateError: Bool = false
    
    // Try to perform user sign up.
    func createAccount() {
        SignUpService.signUp(email: email, firstName: firstName, lastName: lastName, password: password, dob: dob) { (success, error, response) in
            if success {
                self.accountCreated = true
            }else {
                self.accountCreated = false
                self.creationFailed = true
                self.creationErrorType = .signUp
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
        ValidateService.validate(payload: ValidateUserPayload(typ: .email, content: email)) { (success, _, _) in
            DispatchQueue.main.async {
                if success {
                    self.emailError = false
                    self.emailValid = true
                }else {
                    self.emailError = true
                    self.emailValid = false
                }
            }
        }
    }

    func validatePassword() {
        let matching = password == confirmPassword
        
        if !matching {
            self.accountCreated = false
            self.creationFailed = true
            self.creationErrorType = .str
            //TODO(): Give more detail.
            self.creationErrorStr = "Password is not complex enough."
            return
        }

        ValidateService.validate(payload: ValidateUserPayload(typ: .password, content: password)) { (success, _, _) in
            DispatchQueue.main.async {
                if success {
                    // Create account
                    self.createAccount()
                }else {
                    self.accountCreated = false
                    self.creationFailed = true
                    self.creationErrorType = .str
                    //TODO(): Give more detail.
                    self.creationErrorStr = "Password is not complex enough."
                }
            }
        }

    }
    
    func validateDOB() {
        
    }


    func onAppear() {
    }

    func onDisappaer() {
    }

}

enum CreationErrorType {
    case signUp, str
}
