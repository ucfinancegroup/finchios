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
    
    @State var isActive: Bool = false
    
    @State var navAble: Bool
    
    var body: some View {
        NavigationLink(destination: GoalDetailView(shouldPop: $isActive, goal: GoalAndStatusIdentifiable(goalAndStatus: goal)), isActive: $isActive) {
            VStack(alignment: .leading) {
                HStack {
                    Text(goal.goal.name)
                        .font(.title2)
                    
                    Spacer()
                }
                
                Text("\(goal.goal.metric.rawValue) goal of $\(Double.formatOffset(amt: goal.goal.threshold))")
            }
        }
    }
}

//struct GoalItemSummaryView_Previews: PreviewProvider {
//
//    @State static var goal = GoalAndStatus.dummy
//
//    static var previews: some View {
//        GoalItemSummaryView(goal: goal)
//    }
//}
