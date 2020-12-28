//
//  LogInViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 8/21/20.
//  Copyright © 2020 Brett Fazio. All rights reserved.
//

import Foundation
import Combine
import OpenAPIClient

class LogInViewModel: ObservableObject, Identifiable {

    @Published var email: String = ""
    @Published var password: String = ""

    @Published var logInSuccess: Bool = false
    @Published var logInError: Bool = false

    // Try to perform user log-in.
    func logInTapped() {
        LogInService.logIn(email: email, password: password) { (success) in
            
        }
    }
}
