//
//  Account.swift
//  finchios
//
//  Created by Brett Fazio on 1/23/21.
//

import Foundation
import OpenAPIClient

extension Account {
    
    static let dummy = Account(balance: 10000, code: "sdfsfdsfdsfd", message: "CHASE CHECKING")
    
}

struct AccountIdentifiable: Identifiable {
    var id = UUID()
    
    var account: Account
}

struct AccountErrorIdentifiable: Identifiable {
    var id = UUID()
    
    var error: AccountError
}
