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
        Text("Temp")
    }
}

struct EventSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        EventSummaryView()
    }
}
