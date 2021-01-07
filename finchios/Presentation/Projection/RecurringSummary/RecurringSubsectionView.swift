//
//  RecurringSummaryViewItem.swift
//  finchios
//
//  Created by Brett Fazio on 1/7/21.
//

import SwiftUI
import OpenAPIClient

struct RecurringSubsectionView: View {
    
    @State var type: RecurringItemType
    
    @Binding var recurring: [Recurring]
    
    var body: some View {
        Text(type.rawValue)
        
        ForEach(recurring.indices) { index in
            AmountItemSummary(type: $type, recurring: $recurring[index])
        }
    }
}

//struct RecurringSubsectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecurringSummaryViewItem()
//    }
//}
