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
        .background(Color.lightGray)
        .onAppear() {
            self.navBarHidden = true
        }
        .navigationBarTitle(navBarHidden ? "" : "Projection")
        .navigationBarHidden(navBarHidden)
        .navigationBarBackButtonHidden(navBarHidden)
    }
}

struct ProjectionViewPreview: View {
    
    @State var hidden: Bool = true
    
    var body: some View {
        ProjectionView(navBarHidden: $hidden)
    }
    
}

struct ProjectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectionViewPreview()
    }
}
