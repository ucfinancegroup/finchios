//
//  RecurringViewState.swift
//  finchios
//
//  Created by Brett Fazio on 1/8/21.
//

import SwiftUI
import OpenAPIClient

class RecurringViewState: ObservableObject, Identifiable {
    
    @Binding var type: RecurringItemType
    
    init(type: Binding<RecurringItemType>) {
        _type = type
    }
    
}

