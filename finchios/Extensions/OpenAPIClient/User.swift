//
//  User.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import Foundation
import OpenAPIClient

extension User {
    
    init() {
        self.init(email: "", firstName: "", lastName: "", location: Location(hasLocation: true, lat: 0, lon: 0), income: 0, netWorth: 0)
    }
    
}
