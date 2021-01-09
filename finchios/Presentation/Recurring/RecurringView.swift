//
//  RecurringView.swift
//  finchios
//
//  Created by Brett Fazio on 1/8/21.
//

import SwiftUI

struct RecurringView: View {
    
    @Binding var type: RecurringItemType
    
    @ObservedObject var model: RecurringViewState
    
    init(type: Binding<RecurringItemType>) {
        _type = type
        
        model = RecurringViewState(type: type)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(model.recurrings.indices, id: \.self) { index in
                    AmountItemSummary(type: $type, recurring: $model.recurrings[index])
                }
            }
        }
        .onAppear() {
            model.onAppear()
        }
        .navigationBarItems(trailing: NavigationLink(
                                destination: Text("destin"),
                                label: {
                                    Image("Plus")
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
