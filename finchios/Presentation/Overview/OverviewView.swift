//
//  OverviewView.swift
//  finchios
//
//  Created by Brett Fazio on 2/22/21.
//

import SwiftUI
import OpenAPIClient

struct OverviewView: View {
    
    @Binding var navBarHidden: Bool
    
    @StateObject var model = OverviewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                // Present graph
                GraphView(type: .overview)
                    .padding(.bottom)
                
                // Card Stack
                CardStack(insights: $model.insights)
                
                // Accounts
                AccountsSummaryView()
                
                // Expenses
                ExpensesSummaryView()
                
                // Recurring
                RecurringSummaryView(type: .overview)
                
                // Goals
                GoalSummaryView()
            }
        }
        .onAppear() {
            self.navBarHidden = true
            self.model.onAppear()
        }
        .navigationBarTitle(navBarHidden ? "" : "Overview")
        .navigationBarHidden(navBarHidden)
        .navigationBarBackButtonHidden(navBarHidden)
    }
}

struct OverviewViewPreview: View {
    
    @State var hidden: Bool = true
    
    var body: some View {
        OverviewView(navBarHidden: $hidden)
    }
    
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewViewPreview()
    }
}
