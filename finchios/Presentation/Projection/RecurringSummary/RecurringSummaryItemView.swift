//
//  RecurringSummaryViewItem.swift
//  finchios
//
//  Created by Brett Fazio on 1/7/21.
//

import SwiftUI
import OpenAPIClient

enum RecurringSummaryItemType {
    case income, expense
}

struct RecurringSummaryItemView: View {
    
    @State var type: RecurringSummaryItemType
    
    @Binding var model: [Recurring]
    
    var body: some View {
        Text("template")
    }
}

//struct RecurringSummaryItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecurringSummaryViewItem()
//    }
//}
