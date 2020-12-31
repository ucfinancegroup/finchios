//
//  ExpensesItemSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/31/20.
//

import SwiftUI
import OpenAPIClient

struct ExpensesItemSummaryView: View {
    
    @Binding var data: Recurring
    
    var body: some View {
        VStack {
            Text("\(data.name)")
            
            Text("\(data.amount)")
        }
    }
}

//struct ExpensesItemSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpensesItemSummaryView(data: <#Binding<Recurring>#>)
//    }
//}
