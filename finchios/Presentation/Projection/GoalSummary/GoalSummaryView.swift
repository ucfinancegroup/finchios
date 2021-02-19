//
//  GoalSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import SwiftUI

struct GoalSummaryView: View {
    
    @StateObject var model: GoalSummaryViewModel = GoalSummaryViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Goals")
                    .font(.title)
                
                Spacer()
                
                NavigationLink(
                    destination: GoalView(),
                    label: {
                        Image("RightArrow")
                    })
                
            }
            
            if model.goals.count > 0 {
                Divider()
            }

            ForEach(model.goals, id: \.id) { goal in
                GoalItemSummaryView(goal: goal.goalAndStatus, navAble: false)
            }

        }
        .padding()
        .bubble()
        .onAppear() {
            model.fetch()
        }
    }
}

struct GoalSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        GoalSummaryView()
    }
}
