//
//  EventSummaryViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import Foundation
import OpenAPIClient

class EventSummaryViewModel: ObservableObject, Identifiable {
    
    @Published var events: [Event] = []
    
    //TODO(): Consolidate into one getPlans call and filter data into models (getPlans is called for
    // events, recurrings, etc.) Wasteful to make multiple calls
    func onAppear() {
        PlansService.events { (success, _, result) in
            DispatchQueue.main.async {
                if let result = result {
                    self.events = result
                }
            }
        }
    }
}
