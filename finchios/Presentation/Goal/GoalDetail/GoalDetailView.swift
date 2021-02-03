//
//  GoalDetailView.swift
//  finchios
//
//  Created by Brett Fazio on 1/17/21.
//

import SwiftUI

struct GoalDetailView: View {
    
    @Binding var shouldPop: Bool
    
    @State var goal: GoalAndStatusIdentifiable
    
    @State var modalActive: Bool = false
    
    @ObservedObject var model = GoalDetailViewModel()
    
    var body: some View {
        VStack {
            
            //Information
            Group {
                VStack {
                    HStack {
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Text("\(goal.goalAndStatus.goal.metric.rawValue) goal of $\(goal.goalAndStatus.goal.threshold.format())")
                        .padding()
                    
                    Spacer()
                    
                    Text("x% progress")
                    
                    Spacer()
                    
                    Text("Begins on \(Date(timeIntervalSince1970: TimeInterval(goal.goalAndStatus.goal.start))) and ends \(Date(timeIntervalSince1970: TimeInterval(goal.goalAndStatus.goal.end)))")
                        .padding()
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            Button(action: {
                self.model.delete(id: self.goal.goalAndStatus.goal.id.oid)
            }, label: {
                HStack {
                    Spacer()
                    Text("Delete")
                    Spacer()
                }
                .padding()
                .bubble(.red)
                .foregroundColor(.white)
            })
            
        }
        .padding()
        .navigationBarTitle("\(self.goal.goalAndStatus.goal.name)")
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.modalActive = true
                                }, label: {
                                    Text("Edit")
                                })
                                .sheet(isPresented: $modalActive, content: {
                                    GoalEditView(present: $modalActive, goal: $goal.goalAndStatus)
                                }))
        .alert(isPresented: $model.showAlert) { () -> Alert in
            if model.showError {
                return Alert(title: Text("Failed to delete"),
                             message: Text("Failed to delete the goal. Error: \(self.model.errorString)"),
                             dismissButton: .destructive(Text("Okay")) {
                                self.model.showAlert = false
                                self.model.showError = false
                                
                             })
            }
            else { // success
                return Alert(title: Text("Success!"),
                             message: Text("This goal has been successfully deleted."),
                             dismissButton: .default(Text("Okay")) {
                                //self.present = false
                                self.model.showAlert = false
                                self.model.showError = false
                                self.shouldPop = false
                             })
            }
        }
    }
}

struct GoalDetailViewPreview: View {
    
    @State var goal = GoalAndStatusIdentifiable.init(goalAndStatus: .dummy)
    @State var pop = false
    
    
    var body: some View {
        GoalDetailView(shouldPop: $pop, goal: goal)
    }
    
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailViewPreview()
    }
}
