//
//  NewEventModel.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import Foundation
import OpenAPIClient

public class NewEventModel: ObservableObject, Identifiable {
    
    // Alerts
    @Published var showAlert: Bool = false
    
    @Published var showError: Bool = false
    var errorString: String = ""
    
    @Published var showSuccess: Bool = false
    
    @Published public var start: Date = Date()
    
    @Published var examples: [Iden<Event>] = []
    
    @Published public var event: Event = .init(name: "", start: 0, transforms: []) {
        didSet {
            updateTransforms()
        }
    }
    
    @Published var tranforms: [Iden<AssetClassChange>] = []
    
    public init() {
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
    
    public func setSelected(event: Event) {
        self.event = event
    }
    
    public func updateTransforms() {
        self.tranforms = self.event.transforms.map { Iden<AssetClassChange>(obj: $0) }
    }
    
    public func dateValid() -> Bool {
        // Make sure that the date is in the future
        return Date().timeIntervalSince1970 < start.timeIntervalSince1970
    }
    
    func create() {
        event.start = Int64(start.timeIntervalSince1970)
        
        if !dateValid() {
            errorString = "The specified date must be in the future."
            showError = true
            showAlert = true
            return
        }
        
        PlansService.newEvent(payload: event) { (success, _, _, response) in
            DispatchQueue.main.async {
                if let _ = response {
                    // success
                    self.showSuccess = true
                    self.showError = false
                    self.showAlert = true
                }else {
                    self.showError = true
                    self.errorString = "Server error. Please try again."
                    self.showAlert = true
                }
            }
        }
        
    }
    
}
