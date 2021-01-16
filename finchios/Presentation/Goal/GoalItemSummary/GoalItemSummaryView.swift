//
//  GoalItemSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 1/1/21.
//

import SwiftUI
import OpenAPIClient

struct GoalItemSummaryView: View {
    
    @Binding var goal: GoalAndStatus
    
    var body: some View {
        VStack {
            Text("\(goal.goal.name)")
        }
    }
}

struct GoalItemSummaryView_Previews: PreviewProvider {

    @State static var goal = GoalAndStatus.dummy

    static var previews: some View {
        GoalItemSummaryView(goal: $goal)
    }
}
