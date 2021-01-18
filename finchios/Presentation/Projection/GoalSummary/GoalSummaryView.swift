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
            
            ForEach(model.goals.indices) { index in
                GoalItemSummaryView(goal: model.goals[index], navAble: false)
            }
        }
        .padding()
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
