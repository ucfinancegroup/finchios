//
//  EventSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import SwiftUI

struct EventSummaryView: View {
    
    @ObservedObject var model: EventSummaryViewModel = EventSummaryViewModel()
    
    var body: some View {
        VStack {
            ForEach(model.events.indices) { index in
                EventItemSummaryView(model: EventItemSummaryViewModel(event: model.events[index]))
            }
        }
    }
}

struct EventSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        EventSummaryView()
    }
}
