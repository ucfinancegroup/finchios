//
//  Account.swift
//  finchios
//
//  Created by Brett Fazio on 1/23/21.
//

import Foundation
import OpenAPIClient

extension Account {
    
    static let dummy = Account(itemId: "fdsfdsf787s87ds8s", name: "Chase Total Checking", balance: 1000)
    
}

struct AccountIdentifiable: Identifiable {
    var id = UUID()
    
    var account: Account
}

struct AccountErrorIdentifiable: Identifiable {
    var id = UUID()
    
    var error: AccountError
}
