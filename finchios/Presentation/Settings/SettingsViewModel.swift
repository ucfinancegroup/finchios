//
//  SettingsViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/16/20.
//

import Foundation

class SettingsViewModel: ObservableObject, Identifiable {

    @Published var resetApp: Bool = false

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
