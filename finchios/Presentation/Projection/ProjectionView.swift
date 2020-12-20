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
        VStack {
            // Graph
            GraphView()
            
            // Allocation
            AllocationSummaryView()
            
            // Accounts
            
            // Expenses
            
            // Recurring
            RecurringSummaryView()
            
            // Events
        }
        .navigationBarTitle(navBarHidden ? "" : "Projection")
        .navigationBarHidden(navBarHidden)
        .navigationBarBackButtonHidden(navBarHidden)
    }
}
