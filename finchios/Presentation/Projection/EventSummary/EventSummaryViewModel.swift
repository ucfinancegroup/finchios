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
//        PlanAPI.getPlans { (plans, error) in
//            DispatchQueue.main.async {
//                if let error = error {
//                    // Handle
//                    print(error)
//                    return
//                }
//                
//                guard let plans = plans else {
//                    // Handle
//                    return
//                }
//                
//                // Get only events, which are items where the `events` is non-nil
//                let filtered = plans.filter( { $0.events != nil} )
//                self.events = filtered.flatMap { $0.events! }
//                
//                // Get only 3 or less events.
//                self.events = Array(self.events.prefix(3))
//            }
//        }
    }
}
