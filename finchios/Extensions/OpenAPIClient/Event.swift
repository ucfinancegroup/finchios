//
//  Event.swift
//  finchios
//
//  Created by Brett Fazio on 3/21/21.
//

import Foundation
import OpenAPIClient

public extension Event {
    
    static let dummy = Event(id: .dummy,
                             name: "COVID",
                             start: Int64((Date().timeIntervalSince1970+500)),
                             transforms: [.init(_class: .init(typ: .cash), change: -50)])
    
    static let dummyInvalidDate = Event(id: .dummy,
                                        name: "COVID",
                                        start: Int64((Date().timeIntervalSince1970-50000)),
                                        transforms: [.init(_class: .init(typ: .cash), change: -50)])
    
}
