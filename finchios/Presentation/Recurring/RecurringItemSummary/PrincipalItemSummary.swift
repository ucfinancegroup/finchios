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
    
    var body: some View {
        NavigationLink(destination: RecurringDetailView(shouldPop: $isActive, type: $type, recurring: recurring), isActive: $isActive) {
            VStack(alignment: .leading) {
                HStack {
                    Text(recurring.name)
                        .font(.title2)
                    
                    Spacer()
                }
                
                //TODO(): Add how many times annually
                Text("Debt of $\(recurring.principal) compounding at \(Double.format(amt: recurring.interest))")
            }
        }
        .disabled(!navAble)
    }
}

struct PrincipalItemSummaryPreviews: View {
    
    @State var type: RecurringItemType = .income
    
    @State var recurring: Recurring = .dummyIncome
    
    var body: some View {
        PrincipalItemSummary(type: $type, recurring: recurring, navAble: false)
    }
    
}

struct PrincipalItemSummary_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalItemSummaryPreviews()
    }
}
