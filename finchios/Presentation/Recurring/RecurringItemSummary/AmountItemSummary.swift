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
    
    @State var recurring: Recurring
    
    @State var isActive: Bool = false
    
    @State var navAble: Bool
    
    @State var time: OverviewProjection
    
    var body: some View {
        NavigationLink(destination: RecurringDetailView(shouldPop: $isActive, type: $type, recurring: recurring, time: time), isActive: $isActive) {
            VStack(alignment: .leading) {
                HStack {
                    Text(recurring.name)
                        .font(.title2)
                    
                    Spacer()
                }
                
                //TODO(): Add how many times annually
                Text("\(self.type.rawValue) of $\(recurring.amount.format()) every \( recurring.frequency.content) \(convertTo(RecurringIntervalType.from(recurring.frequency.typ)))")
            }
        }
        .disabled(!navAble)
        .foregroundColor(.primary)
    }
    
    public func convertTo(_ og: RecurringIntervalType) -> String {
        switch og {
        case .annually:
            return "year(s)"
        case .daily:
            return "day(s)"
        case .monthly:
            return "month(s)"
        case .weekly:
            return "week(s)"
        }
    }
}

struct AmountItemSummaryPreviews: View {
    
    @State var type: RecurringItemType = .income
    
    @State var recurring: Recurring = .dummyIncome
    
    var body: some View {
        AmountItemSummary(type: $type, recurring: recurring, isActive: false, navAble: false, time: .overview)
    }
    
}

struct AmountItemSummary_Previews: PreviewProvider {
    static var previews: some View {
        AmountItemSummaryPreviews()
    }
}
