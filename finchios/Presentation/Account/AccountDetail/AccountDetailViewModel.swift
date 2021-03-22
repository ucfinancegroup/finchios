//
//  AccountDetailViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 1/23/21.
//

import Foundation
import OpenAPIClient

class AccountDetailViewModel: ObservableObject, Identifiable {
    
    @Published var showAlert: Bool = false
    
    @Published var success: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorString: String = ""
    
    func delete(item: Account) {
        
        let payload = SetAccountAsHiddenPayload(itemId: item.itemId, accountId: item.accountId, hideOrNot: true)
        
        AccountsService.hide(payload: payload) { (success, error, result) in
            DispatchQueue.main.async {
                self.success = false
                self.showError = false
                self.errorString = ""
                
                if success {
                    self.success = true
                }else {
                    self.showError = true
                    if let error = error {
                        self.errorString = "\(error)"
                    }
                }
                
                self.showAlert = true
            }
        }
    }
    
}
