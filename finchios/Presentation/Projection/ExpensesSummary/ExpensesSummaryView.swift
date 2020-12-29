//
//  ExpensesSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import SwiftUI

struct ExpensesSummaryView: View {
    
    @ObservedObject var model = ExpensesSummaryViewModel()
    
    var body: some View {
        Text("expenses")
    }
}

struct ExpensesSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesSummaryView()
    }
}
