//
//  RecurringSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import SwiftUI

struct RecurringSummaryView: View {
    
    @StateObject var model: RecurringSummaryViewModel = RecurringSummaryViewModel()
    
    @State var type: OverviewProjection
    
    var body: some View {
        VStack {
            
            RecurringSubsectionView(type: .income, time: type, recurrings: self.$model.incomes)
                .bubble()
            
            RecurringSubsectionView(type: .expense, time: type, recurrings: self.$model.expenses)
                .bubble()
            
            RecurringSubsectionView(type: .debt, time: type, recurrings: self.$model.debts)
                .bubble()
            
        }
        .onAppear() {
            model.onAppear(type: type)
        }
    }
}

struct RecurringSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        RecurringSummaryView(type: .overview)
    }
}
