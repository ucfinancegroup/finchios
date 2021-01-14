//
//  RecurringSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import SwiftUI

struct RecurringSummaryView: View {
    
    @ObservedObject var model: RecurringSummaryViewModel = RecurringSummaryViewModel()
    
    var body: some View {
        VStack {
            
            RecurringSubsectionView(type: .income, recurrings: self.$model.incomes)
            
            Spacer()
                .frame(height: 30)
            
            RecurringSubsectionView(type: .expense, recurrings: self.$model.expenses)

            Spacer()
                .frame(height: 30)
            
            RecurringSubsectionView(type: .debt, recurrings: self.$model.debts)
            
        }
        .onAppear() {
            model.onAppear()
        }
    }
}

struct RecurringSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        RecurringSummaryView()
    }
}
