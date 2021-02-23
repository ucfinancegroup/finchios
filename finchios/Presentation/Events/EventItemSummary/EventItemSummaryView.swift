//
//  EventItemSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/20/20.
//

import SwiftUI
import OpenAPIClient

struct EventItemSummaryView: View {
    
    @State var event : Event
    
    @State var isActive: Bool = false
    
    @State var navAble: Bool
    
    var body: some View {
        NavigationLink(destination: EventDetailView(shouldPop: $isActive, event: event), isActive: $isActive) {
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.title3)
                
                Text("Starts \(event.start) day(s) from now")
            }
        }
    }
}

//TODO(): Later
//struct EventItemSummaryView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        EventItemSummaryView(event: , navAble: <#T##Bool#>)
//    }
//}
