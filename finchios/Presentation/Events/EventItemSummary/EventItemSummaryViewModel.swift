//
//  EventItemSummaryViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/20/20.
//

import Foundation
import OpenAPIClient

class EventItemSummaryViewModel : ObservableObject, Identifiable {
    
    @Published var event: Event
    
    init(event: Event) {
        self.event = event
    }
    
}
