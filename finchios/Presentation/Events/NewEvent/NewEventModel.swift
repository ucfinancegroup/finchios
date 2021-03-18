//
//  NewEventModel.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import Foundation
import OpenAPIClient

class NewEventModel: ObservableObject, Identifiable {
    
    // Alerts
    @Published var showAlert: Bool = false
    
    @Published var showError: Bool = false
    var errorString: String = ""
    
    @Published var showSuccess: Bool = false
    
    @Published var start: Date = Date()
    
    @Published var examples: [Iden<Event>] = []
    
    var event: Event = .init(name: "", start: 0, transforms: [])
    
    init() {
        EventService.example { (success, _, result) in
            DispatchQueue.main.async {
                if let result = result {
                    self.examples = result.map { Iden<Event>(obj: $0) }
                    
                    if let first = self.examples.first {
                        self.event = first.obj
                    }
                }
            }
        }
    }
    
    func setSelected(event: Event) {
        self.event = event
    }
    
    private func dateValid() -> Bool {
        // Make sure that the date is in the future
        return Date().timeIntervalSince1970 < start.timeIntervalSince1970
    }
    
    func create() {
        
        if !dateValid() {
            errorString = "The specified date must be in the future."
            showError = true
            showAlert = true
            return
        }
        
        
    }
    
}
