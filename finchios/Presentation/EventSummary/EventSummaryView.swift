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
            
            ForEach(model.events, id:\.id) { item in
                EventItemSummaryView(event: item.obj, navAble: false)
            }
        }
        .onAppear() {
            model.onAppear()
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
