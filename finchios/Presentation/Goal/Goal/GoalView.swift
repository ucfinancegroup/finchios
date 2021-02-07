//
//  GoalView.swift
//  finchios
//
//  Created by Brett Fazio on 1/15/21.
//

import SwiftUI
import OpenAPIClient

struct GoalView: View {
    
    @State var isActive: Bool = false
    
    @ObservedObject var model: GoalViewModel = GoalViewModel()
    
    @State var modalCreate: Bool = false
    
    public init() { }
    
    fileprivate init(goals: [GoalAndStatusIdentifiable]) {
        model.goals = goals
    }
    
    var body: some View {
             ScrollView {
                LazyVStack {
                    ForEach(model.goals, id: \.id) { goal in
                        GoalItemSummaryView(goal: goal.goalAndStatus, navAble: true)
                            .padding()
                            .bubble()
                        
                    }
                }
                
            }
        .onAppear() {
            //TODO(): Probably don't want to fetch every time you
            // return to this view
            self.isActive = false
            model.onAppear()
        }
        .navigationTitle(Text("Goals"))
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.modalCreate = true
                                }, label: {
                                    Image("Plus")
                                })
                                .sheet(isPresented: self.$modalCreate, content: {
                                    NewGoalView(present: self.$modalCreate)
                                }))
        
    }
}

struct GoalViewProvider: View {

    var body: some View {
        NavigationView {
            GoalView(goals: [.init(goalAndStatus: .dummy)])
        }
    }
    
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalViewProvider()
    }
}
