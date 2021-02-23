//
//  EventSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import SwiftUI

struct EventSummaryView: View {
    
    @StateObject var model: EventSummaryViewModel = EventSummaryViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Simulated Events")
                    .font(.title)
                
                Spacer()
                
                NavigationLink(
                    destination: Text("EventView here"),
                    label: {
                        Image("RightArrow")
                    })

            }
            
            ForEach(model.events.indices) { index in
                EventItemSummaryView(model: EventItemSummaryViewModel(event: model.events[index]))
            }
        }
        .padding()
        .bubble()
    }
}

struct EventSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        EventSummaryView()
    }
}
