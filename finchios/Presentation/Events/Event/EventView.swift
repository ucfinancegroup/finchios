//
//  EventView.swift
//  finchios
//
//  Created by Brett Fazio on 2/23/21.
//

import SwiftUI

struct EventView: View {
    
    @State var isActive: Bool = false
    
    @StateObject var model: EventModel = EventModel()
    
    @State var modalCreate: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(model.events, id: \.id) { event in
                    EventItemSummaryView(event: event.obj, navAble: true)
                        .padding()
                        .bubble()
                }
            }
        }
        .onAppear() {
            self.isActive = false
            model.onAppear()
        }
        .navigationTitle(Text("Simulated Events"))
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.modalCreate = true
                                }, label: {
                                    Image("Plus")
                                })
                                .sheet(isPresented: self.$modalCreate, content: {
                                    //TODO(): Put NewEvent here
                                    Text("New Event should go here")
                                    //NewRecurringView(present: self.$modalCreate, type: self.$type, time: time)
                                }))
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
