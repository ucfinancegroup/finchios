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
    
    @Binding var recurrings: [Recurring]
    
    var body: some View {
        Text(type.rawValue)
        
        ForEach(recurrings.indices) { index in
            AmountItemSummary(type: $type, recurring: $recurrings[index])
        }
    }
}

struct RecurringSubsectionViewPreview: View {
    
    @State var type: RecurringItemType = .income
    
    @State var recurrings: [Recurring] = [.dummyIncome, .dummyIncome]
    
    var body: some View {
        RecurringSubsectionView(type: type, recurrings: $recurrings)
    }
    
}

struct RecurringSubsectionView_Previews: PreviewProvider {
    static var previews: some View {
        RecurringSubsectionViewPreview()
    }
}