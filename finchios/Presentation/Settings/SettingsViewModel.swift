//
//  SettingsViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/16/20.
//

import Foundation
import OpenAPIClient

class SettingsViewModel: ObservableObject, Identifiable {

    @Published var resetApp: Bool = false

    var user: User = User()
    
    func onAppear() {
        // TODO() Point of doing this here is to pass it to the change name and change income views
        UserService.get { (_, _, user) in
            if let user = user {
                self.user = user
            }
        }
    }
    
    func logOut() {
        // Wipe local credentials
        CredentialsObject.deleteCurrentCredentials { (success) in
            if success {
                // Take the user back to the home screen
                self.resetApp = true
            } else {
                // TODO(): Notify user
            }
        }

    }

}
