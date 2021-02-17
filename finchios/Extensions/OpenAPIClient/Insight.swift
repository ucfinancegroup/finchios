//
//  Insight.swift
//  finchios
//
//  Created by Brett Fazio on 1/24/21.
//

import Foundation
import OpenAPIClient

extension Insight {
    
    static let empty = Insight(id: .dummy, title: "", description: "", insightType: .goal, dismissed: false, generationTime: 0, imageURL: nil)
    static let dummy = Insight(id: .dummy, title: "A very cool insight.", description: "This insight has type goal", insightType: .goal, dismissed: false, generationTime: 0, imageURL: nil)
}
