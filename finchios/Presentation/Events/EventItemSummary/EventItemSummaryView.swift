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
                
                Text("Starts \(getDays()) day(s) from now")
            }
        }
        .disabled(!navAble)
        .foregroundColor(.primary)
    }
    
    func getDays() -> Int {
        guard let ret = Calendar.current.dateComponents([.day], from: Date(), to: Date(timeIntervalSince1970: TimeInterval(event.start))).day else {
            return 0
        }
        
        return ret
    }
}

//TODO(): Later
//struct EventItemSummaryView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        EventItemSummaryView(event: , navAble: <#T##Bool#>)
//    }
//}
