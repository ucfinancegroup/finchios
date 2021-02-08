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
import CoreLocation

class SignUpModel: NSObject, ObservableObject, Identifiable, CLLocationManagerDelegate {

    private let clmanager: CLLocationManager = CLLocationManager()
    private var location: CLLocation?
    
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
        
        let loc: Location
        if let location = location {
            loc = Location(hasLocation: true, lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        }else {
            loc = Location(hasLocation: false, lat: 0, lon: 0)
        }
        
        SignUpService.signUp(email: email, firstName: firstName, lastName: lastName, password: password, dob: dob, loc: loc) { (success, error, response) in
            DispatchQueue.main.async {
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
        ValidateService.validate(payload: ValidateUserPayload(field: .email, content: email)) { (success, _, _) in
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
            self.creationErrorStr = "Passwords do not match."
            return
        }

        ValidateService.validate(payload: ValidateUserPayload(field: .password, content: password)) { (success, _, _) in
            DispatchQueue.main.async {
                if success {
                    // Try to get user's location (which in turn calls create account)
                    self.requestLocation()
                }else {
                    self.accountCreated = false
                    self.creationFailed = true
                    self.creationErrorType = .str
                    self.creationErrorStr = "Password is not complex enough. It needs to be longer than 7 characters."
                }
            }
        }

    }
    
    func requestLocation() {
        clmanager.requestLocation()
    }
    
    private static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "YYYY-MM-dd"
        return f
    }()
    
    func formatedDOB() -> String {
        return SignUpModel.formatter.string(from: self.dob)
    }
    
    func validateDOB() {
        ValidateService.validate(payload: ValidateUserPayload(field: .birthday, content: formatedDOB())) { (success, _, _) in
            DispatchQueue.main.async {
                if success {
                    self.dobValid = true
                    self.dobError = false
                }else {
                    self.dobValid = false
                    self.dobError = true
                }
            }
        }
    }


    func onAppear() {
        clmanager.delegate = self
    }

    func onDisappaer() {
    }

}

extension SignUpModel { // CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
        }
        self.createAccount()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.createAccount()
    }
    
}

enum CreationErrorType {
    case signUp, str
}
