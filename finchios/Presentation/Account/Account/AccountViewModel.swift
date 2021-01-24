//
//  AccountViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 1/23/21.
//

import Foundation

class AcccountViewModel: Identifiable, ObservableObject {
    
    @Published var accounts: [AccountIdentifiable] = []
    @Published var errors: [AccountErrorIdentifiable] = []
    
    func onAppear() {
        
        AccountsService.accounts { (success, error, response) in
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
    
}
