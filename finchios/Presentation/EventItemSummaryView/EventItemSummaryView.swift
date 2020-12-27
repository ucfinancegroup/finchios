//
//  EventItemSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/20/20.
//

import SwiftUI
import OpenAPIClient

struct EventItemSummaryView: View {
    
    @ObservedObject var model : EventItemSummaryViewModel
    
    var body: some View {
        VStack {
            Text("placeholder")
        }
    }
}

struct EventItemSummaryView_Previews: PreviewProvider {

    static var previews: some View {
        EventItemSummaryView(model: EventItemSummaryViewModel(event: Event(name: "Test Event", start: 5, transforms: [])))
    }
}
