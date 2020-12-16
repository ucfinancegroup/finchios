//
//  StartUpViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 8/23/20.
//  Copyright © 2020 Brett Fazio. All rights reserved.
//

import Foundation
import Combine
import OpenAPIClient

class StartUpViewModel: ObservableObject, Identifiable {

    @Published var segueLanding: Bool = false
    @Published var segueApp: Bool = false

    func viewAppeared() {
        self.segueLanding = false
        self.segueApp = false
        // Get the singleton and see if a log in and be performed with the JWT.
        let cred = CredentialsObject.shared

        if !cred.isSet() {
            // Go to landing page
            segueLanding = true
            return
        }

        // Test out the JWT token, if it works enter the app.
        //TODO(Will): Give route to verify JWT

        // If the JWT doesn't work try the username/password
        let payload = LoginPayload(email: cred.email, password: cred.password)
        
        OpenAPIClient.UserAPI.loginUser(loginPayload: payload) { (response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    self.segueLanding = true
                }else {
                    self.segueApp = true
                }
            }
        }
    }

}
