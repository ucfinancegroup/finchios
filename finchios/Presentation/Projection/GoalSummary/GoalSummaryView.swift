//
//  GoalSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import SwiftUI

struct GoalSummaryView: View {
    
    @ObservedObject var model: GoalSummaryViewModel = GoalSummaryViewModel()
    
    var body: some View {
        ForEach(model.goals.indices) { index in
            GoalItemSummaryView(goal: $model.goals[index])
        }
    }
}

struct GoalSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        GoalSummaryView()
    }
}
