//
//  IncomeItemSummary.swift
//  finchios
//
//  Created by Brett Fazio on 1/7/21.
//

import SwiftUI
import OpenAPIClient

struct AmountItemSummary: View {
    
    @Binding var type: RecurringItemType
    
    @Binding var recurring: Recurring
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(recurring.name)
                    .font(.title2)
                
                Spacer()
            }
            
            
            //TODO(): Add how many times annually
            Text("\(self.type.rawValue) of $\(String(format:"%.02f", Double(hundredOffsetInt: Int(recurring.amount)))) \(recurring.frequency.typ.rawValue)")
        }
    }
}

struct AmountItemSummaryPreviews: View {
    
    @State var type: RecurringItemType = .income
    
    @State var recurring: Recurring = .dummyIncome
    
    var body: some View {
        AmountItemSummary(type: $type, recurring: $recurring)
    }
    
}

struct AmountItemSummary_Previews: PreviewProvider {
    static var previews: some View {
        AmountItemSummaryPreviews()
    }
}
