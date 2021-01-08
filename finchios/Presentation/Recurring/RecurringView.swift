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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct RecurringView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecurringView()
//    }
//}
