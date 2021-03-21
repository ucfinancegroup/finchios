//
//  PrincipalItemSummary.swift
//  finchios
//
//  Created by Brett Fazio on 1/14/21.
//

import SwiftUI
import OpenAPIClient

struct PrincipalItemSummary: View {
    
    @Binding var type: RecurringItemType
    
    @State var recurring: Recurring
    
    @State var isActive: Bool = false
    
    @State var navAble: Bool
    
    @State var time: OverviewProjection
    
    var body: some View {
        //TODO() Should isActive be navAble?
        NavigationLink(destination: RecurringDetailView(shouldPop: $isActive, type: $type, recurring: recurring, time: time), isActive: $isActive) {
            VStack(alignment: .leading) {
                HStack {
                    Text(recurring.name)
                        .font(.title2)
                    
                    Spacer()
                }
                
                Text("Debt of $\(recurring.principal.format()) compounding at \(recurring.interest.format())% every \(recurring.frequency.content) \(convertTo(RecurringIntervalType.from(recurring.frequency.typ)))")
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

struct PrincipalItemSummaryPreviews: View {
    
    @State var type: RecurringItemType = .income
    
    @State var recurring: Recurring = .dummyIncome
    
    var body: some View {
        PrincipalItemSummary(type: $type, recurring: recurring, navAble: false, time: .overview)
    }
    
}

struct PrincipalItemSummary_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalItemSummaryPreviews()
    }
}
