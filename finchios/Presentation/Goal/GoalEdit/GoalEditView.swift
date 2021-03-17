//
//  GoalEditView.swift
//  finchios
//
//  Created by Brett Fazio on 1/18/21.
//

import SwiftUI
import OpenAPIClient

struct GoalEditView: View {
    
    @Binding var present: Bool
    
    @Binding var goal: GoalAndStatus
    
    @StateObject var model: GoalEditViewModel = GoalEditViewModel()
    
    var body: some View {
        VStack {
            
            Group {
                
                Spacer()
                
                TextField("Name", text: self.$model.name)
                
                Spacer()
                
                DatePicker("Start", selection: self.$model.start, displayedComponents: .date)
                
                Spacer()
                
                DatePicker("End", selection: self.$model.end, displayedComponents: .date)
                
                Spacer()
                
                NumberField(text: $model.threshold, alignment: .natural, keyType: .decimalPad, placeholder: "Target")
                
                Spacer()
                
                Picker("Metric", selection: self.$model.metric) {
                    ForEach(GoalMetricIdentifiable.allCases, id: \.id) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                
            }
            
            Spacer()
            
            Button {
                UIApplication.shared.endEditing()
                self.model.edit(id: goal.goal.id.oid)
            } label: {
                Text("Save Edit")
            }
            
        }
        // TODO(): Not showing because it is a modal sheet?
        .alert(isPresented: $model.showAlert) { () -> Alert in
            if model.alertType == .fail {
                return Alert(title: Text("Failed to edit"),
                             message: Text("Failed to edit the goal. Error: \(self.model.errorDetail)"),
                             dismissButton: .destructive(Text("Okay")) {
                                self.model.showAlert = false
                             })
            }
            else { // success
                return Alert(title: Text("Success!"),
                             message: Text("This goal has been successfully edited."),
                             dismissButton: .default(Text("Okay")) {
                                self.present = false
                             })
            }
        }
        .padding()
        .onAppear() {
            self.model.set(goal: self.goal)
        }

    }
}

//struct RecurringEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecurringEditView()
//    }
//}
