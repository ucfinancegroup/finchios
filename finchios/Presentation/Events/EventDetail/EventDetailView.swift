//
//  EventDetailView.swift
//  finchios
//
//  Created by Brett Fazio on 2/23/21.
//

import SwiftUI
import OpenAPIClient

struct EventDetailView: View {
    
    @Binding var shouldPop: Bool
    
    @State var event: Event
    
    @State var modalActive: Bool = false
    
    //@StateObject var model: RecurringDetailViewModel = RecurringDetailViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct EventDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetailView()
//    }
//}
