//
//  RecurringDetailView.swift
//  finchios
//
//  Created by Brett Fazio on 1/14/21.
//

import SwiftUI
import OpenAPIClient

struct RecurringDetailView: View {
    
    @Binding var type: RecurringItemType
    
    @Binding var recurring: Recurring
    
    var body: some View {
        Text(recurring.name)
    }
}

//struct RecurringDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecurringDetailView()
//    }
//}
