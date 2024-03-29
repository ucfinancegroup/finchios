//
//  RecurringView.swift
//  finchios
//
//  Created by Brett Fazio on 1/8/21.
//

import SwiftUI

struct RecurringView: View {
    
    @State var isActive: Bool = false
    
    @Binding var type: RecurringItemType
    
    @StateObject var model: RecurringViewState = RecurringViewState()
    
    @State var modalCreate: Bool = false
    
    var time: OverviewProjection
    
    init(type: Binding<RecurringItemType>, time: OverviewProjection) {
        _type = type
        self.time = time
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(model.recurrings, id: \.id) { recurring in
                    if self.type == .income || self.type == .expense {
                        AmountItemSummary(type: $type, recurring: recurring.recurring, navAble: true, time: time)
                            .padding()
                            .bubble()
                    }else { // is debt
                        PrincipalItemSummary(type: $type, recurring: recurring.recurring, navAble: true, time: time)
                            .padding()
                            .bubble()
                    }
                    
                }
            }
        }
        .onAppear() {
            self.isActive = false
            model.onAppear(type: type, time: time)
        }
        .navigationTitle(Text("\(time == .projection ? "Future " : "")\(type.rawValue)s"))
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.modalCreate = true
                                }, label: {
                                    Image("Plus")
                                })
                                .sheet(isPresented: self.$modalCreate, onDismiss: {
                                    model.onAppear(type: type, time: time)
                                }, content: {
                                    NewRecurringView(present: self.$modalCreate, type: self.$type, time: time)
                                }))
        
    }
}

struct RecurringViewProvider: View {
    
    @State var type: RecurringItemType = .income
    
    var body: some View {
        RecurringView(type: $type, time: .overview)
    }
    
}

struct RecurringView_Previews: PreviewProvider {
    static var previews: some View {
        RecurringViewProvider()
    }
}
