//
//  ProjectionView.swift
//  finchios
//
//  Created by Brett Fazio on 12/16/20.
//

import SwiftUI

struct ProjectionView: View {

    @Binding var navBarHidden: Bool

    @ObservedObject var model: ProjectionViewModel = ProjectionViewModel()
    
    var body: some View {
        ScrollView {
            VStack {

            // Graph
            GraphView()
            
            // Allocation
            AllocationSummaryView()
            
            // Accounts
            AccountsSummaryView()
            
            // Expenses
            ExpensesSummaryView()
            
            // Recurring
            RecurringSummaryView()
            
            // Goals
            GoalSummaryView()
            
            // Events
            EventSummaryView()
            
            }
        }
        .onAppear() {
            self.navBarHidden = true
        }
        .navigationBarTitle(navBarHidden ? "" : "Projection")
        .navigationBarHidden(navBarHidden)
        .navigationBarBackButtonHidden(navBarHidden)
    }
}
