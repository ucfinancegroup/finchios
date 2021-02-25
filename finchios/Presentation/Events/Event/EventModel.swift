//
//  EventModel.swift
//  finchios
//
//  Created by Brett Fazio on 2/23/21.
//

import Foundation
import OpenAPIClient

class EventModel: ObservableObject, Identifiable {
    
    @Published var events: [Iden<Event>] = []
    
    func onAppear() {
        
    }
    
}
