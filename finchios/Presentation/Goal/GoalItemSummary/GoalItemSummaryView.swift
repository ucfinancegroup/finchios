//
//  GoalItemSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 1/1/21.
//

import SwiftUI
import OpenAPIClient

struct GoalItemSummaryView: View {
    
    @State var goal: GoalAndStatus
    
    var body: some View {
        VStack {
            Text("\(goal.goal.name)")
                .font(.title2)
            
            Text("\(goal.goal.metric.rawValue) goal of $\(goal.goal.threshold)")
        }
    }
}

struct GoalItemSummaryView_Previews: PreviewProvider {

    @State static var goal = GoalAndStatus.dummy

    static var previews: some View {
        GoalItemSummaryView(goal: goal)
    }
}
