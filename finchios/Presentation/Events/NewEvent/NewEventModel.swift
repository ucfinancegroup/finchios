//
//  NewEventModel.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import Foundation
import OpenAPIClient

class NewEventModel: ObservableObject, Identifiable {
    
    @Published var showAlert: Bool = false
    @Published var alertType: SuccessFail = .success
    @Published var errorDetail: String = ""
    
    func create() {
        
    }
    
}
