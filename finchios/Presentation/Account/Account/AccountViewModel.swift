//
//  AccountViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 1/23/21.
//

import Foundation

public class AcccountViewModel: Identifiable, ObservableObject {
    
    @Published var accounts: [AccountIdentifiable] = []
    @Published var errors: [AccountErrorIdentifiable] = []
    
    public func onAppear() {
        
        // Set all to false to just get unhidden accounts
        AccountsService.accounts(all: false) { (success, error, response) in
            DispatchQueue.main.async {
                if let response = response {
                    
                    self.accounts = response.accounts.map { AccountIdentifiable(account: $0) }
                    self.errors = response.errors.map { AccountErrorIdentifiable(error: $0) }
                    
                }else {
                    // show error
                }
            }
        }
        
    }
    
    public func formatErrors() -> String {
        var formatted: String = ""
        
        errors.forEach { formatted.append( $0.error.message + ", " ) }
        
        return formatted
    }
    
}
