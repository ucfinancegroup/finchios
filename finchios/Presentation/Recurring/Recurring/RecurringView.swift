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
    
    @ObservedObject var model: RecurringViewState
    
    @State var modalCreate: Bool = false
    
    init(type: Binding<RecurringItemType>) {
        _type = type
        
        model = RecurringViewState(type: type)
    }
    
    var body: some View {
            VStack {
                List {
                    ForEach(model.recurrings, id: \.id) { recurring in
                        if self.type == .income || self.type == .expense {
                            AmountItemSummary(type: $type, recurring: recurring.recurring, navAble: true)
                                .padding()
                        }else { // is debt
                            PrincipalItemSummary(type: $type, recurring: recurring.recurring, navAble: true)
                                .padding()
                        }
                        
                    }
                }
            }
        .onAppear() {
            self.isActive = false
            model.onAppear()
        }
        .navigationTitle(Text(type.rawValue))
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.modalCreate = true
                                }, label: {
                                    Image("Plus")
                                })
                                .sheet(isPresented: self.$modalCreate, content: {
                                    NewRecurringView(present: self.$modalCreate, type: self.$type)
                                }))
        
    }
}

struct RecurringViewProvider: View {
    
    @State var type: RecurringItemType = .income
    
    var body: some View {
        RecurringView(type: $type)
    }
    
}

struct RecurringView_Previews: PreviewProvider {
    static var previews: some View {
        RecurringViewProvider()
    }
}
