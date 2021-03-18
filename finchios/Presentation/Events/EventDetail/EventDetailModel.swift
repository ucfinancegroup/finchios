//
//  EventDetailModel.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import Foundation
import OpenAPIClient

class EventDetailModel: ObservableObject, Identifiable {
    
    @Published var showAlert: Bool = false
    
    @Published var success: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorString: String = ""
    
    @Published var tranforms: [Iden<AssetClassChange>] = []
    
    @Published var name: String = ""
    
    func setup(event: Event) {
        tranforms = updateTransforms(event: event)
    }
    
    
    func updateTransforms(event: Event) -> [Iden<AssetClassChange>] {
        return event.transforms.map { Iden<AssetClassChange>(obj: $0) }
    }
    
    func delete(id: String) {
        PlansService.deleteEvent(id: id) { (success, error, _, response) in
            DispatchQueue.main.async {
                self.success = false
                self.showError = false
                self.errorString = ""
                
                if success {
                    self.success = true
                }else {
                    self.showError = true
                    if let error = error {
                        self.errorString = "\(error)"
                    }
                }
                
                self.showAlert = true
            }
        }
    }
    
}
