//
//  SignUpView.swift
//  ubump-ios
//
//  Created by Brett Fazio on 8/23/20.
//  Copyright © 2020 Brett Fazio. All rights reserved.
//

import Foundation
import Combine
import OpenAPIClient

class SignUpModel: ObservableObject, Identifiable {

    // Input data
    @Published var uBumpCode: String = ""
    @Published var email: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    // For account creation success/failure
    @Published var accountCreated: Bool = false
    @Published var creationFailed: Bool = false
    @Published var creationErrorType: CreationErrorType = .signUp

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
        
        let payload = SignupPayload(email: email, password: password, firstName: "temp", lastName: "temp", income: 0.0)
        
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

    func validateUsername() {
        // TODO(): Valid symbol check

        // Make sure it is available
//        AuthAvailableService.usernameAvailable(username: username) { (result) in
//            DispatchQueue.main.async {
//                if result {
//                    // is available
//                    self.usernameError = false
//                    self.usernameValid = true
//                } else {
//                    // not available
//                    self.usernameError = true
//                    self.usernameValid = false
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
