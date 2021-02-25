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
                    destination: EventView(),
                    label: {
                        Image("RightArrow")
                    })

            }
            
            ForEach(model.events.indices) { index in
                EventItemSummaryView(event: model.events[index], navAble: false)
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
