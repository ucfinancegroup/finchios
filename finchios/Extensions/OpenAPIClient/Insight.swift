//
//  Insight.swift
//  finchios
//
//  Created by Brett Fazio on 1/24/21.
//

import Foundation
import OpenAPIClient

extension Insight {
    
    static let empty = Insight(title: "", description: "", insightType: .goal, dismissed: false, generationTime: 0, imageURL: nil)
    
}
