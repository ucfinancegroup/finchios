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
        GoalView()
    }
    
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalViewProvider()
    }
}
