//
//  RecurringProtocol.swift
//  finchios
//
//  Created by Brett Fazio on 2/23/21.
//

import Foundation
import OpenAPIClient

public protocol RecurringProtocol {
    static func incomes(completion: @escaping ((Bool, Error?, [Recurring]?) -> Void))
    static func expenses(completion: @escaping ((Bool, Error?, [Recurring]?) -> Void))
    static func debt(completion: @escaping ((Bool, Error?, [Recurring]?) -> Void))
}
