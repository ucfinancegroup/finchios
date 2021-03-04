//
//  RecurringDetailViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 1/14/21.
//

import Foundation

class RecurringDetailViewModel: ObservableObject, Identifiable {
    
    @Published var showAlert: Bool = false
    
    @Published var success: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorString: String = ""
    
    func delete(id: String, time: OverviewProjection) {
        
        //TODO(): Delete in the right place
        
        RecurringService.deleteRecurring(id: id) { (success, error, result, plan) in
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
