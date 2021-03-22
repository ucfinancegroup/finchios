//
//  AccountsSummaryViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation

class AccountsSummaryViewModel: ObservableObject, Identifiable {
    
    @Published var accounts: [AccountIdentifiable] = []
    @Published var errors: [AccountErrorIdentifiable] = []
    
    func onAppear() {
        
        AccountsService.accounts(all: false) { (success, error, response) in
            DispatchQueue.main.async {
                if let response = response {
                    
                    self.accounts = Array(response.accounts.map { AccountIdentifiable(account: $0) }.prefix(3))
                    self.errors = response.errors.map { AccountErrorIdentifiable(error: $0) }
                    
                }else {
                    // show error
                }
            }
        }
        
    }
    
}
