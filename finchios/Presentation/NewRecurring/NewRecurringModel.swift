//
//  NewRecurringModel.swift
//  finchios
//
//  Created by Brett Fazio on 1/11/21.
//

import Foundation
import OpenAPIClient

class NewRecurringModel: ObservableObject, Identifiable {
    
    @Published var name: String = ""
    
    @Published var start: Date = Date()
    @Published var end: Date = Date()
    
    @Published var amountField: String = ""
    
    @Published var principalField: String = ""
    @Published var interestField: String = ""
    
    @Published var typ: String = "monthly"
    @Published var freqContentField: String = ""
    
    func create() {
        
    }
}
