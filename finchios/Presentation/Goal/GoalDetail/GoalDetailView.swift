//
//  GoalDetailView.swift
//  finchios
//
//  Created by Brett Fazio on 1/17/21.
//

import SwiftUI
import Charts

struct GoalDetailView: View {
    
    @Binding var shouldPop: Bool
    
    @State var goal: GoalAndStatusIdentifiable
    
    @State var modalActive: Bool = false
    
    @StateObject var model = GoalDetailViewModel()
    
    private let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MM/dd/yyyy"
        return f
    }()
    
    var body: some View {
        VStack {
            
            //Information
            Group {
                VStack {
                    HStack {
                        Spacer()
                    }
                    
                    HStack {
                        Text("Starts \(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(goal.goalAndStatus.goal.start))))")

                            
                        Spacer()
                    }
                    .padding()
                    
                    
                    HStack {
                        Text("Ends \(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(goal.goalAndStatus.goal.end))))")

                            
                        Spacer()
                    }
                    .padding()

                    Spacer()
                        .frame(height: 30)
                    
                    Text("\(goal.goalAndStatus.goal.metric.rawValue) goal of $\(goal.goalAndStatus.goal.threshold.format())")
                        .padding()
                        .font(.title3)
                    
                    Spacer()
                    
                    Text("\((goal.goalAndStatus.progress*100).format())% progress\(goal.goalAndStatus.progress >= 0.5 ? "!" : ".")")
                    
                    BarView(percent: $goal.goalAndStatus.progress)

                    
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
