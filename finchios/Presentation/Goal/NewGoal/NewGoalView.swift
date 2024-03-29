//
//  NewGoalView.swift
//  finchios
//
//  Created by Brett Fazio on 1/16/21.
//

import SwiftUI
import OpenAPIClient

struct NewGoalView: View {
    
    @Binding var present: Bool
    
    @StateObject var model = NewGoalViewModel()
    
    var body: some View {
        VStack {
            Text("Create a new goal")
                .font(.title2)
                .padding()
            
            Divider()
            
            Group {
                
                Spacer()
                
                TextField("Name", text: self.$model.name)
                
                Spacer()
                
                DatePicker("Start", selection: self.$model.start, displayedComponents: .date)
                
                Spacer()
                
                DatePicker("End", selection: self.$model.end, displayedComponents: .date)
                
                Spacer()
                
                HStack {
                    
                    Text("\(self.model.metric.rawValue) Goal of $")
                    
                    NumberField(text: $model.threshold, alignment: .natural, keyType: .decimalPad, placeholder: "Target")
                    
                }
                
                
                
                Spacer()
                
                Picker("Metric", selection: self.$model.metric) {
                    ForEach(GoalMetricIdentifiable.allCases, id: \.id) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                
            }
            
            Spacer()
            
            Button(action: {
                UIApplication.shared.endEditing()
                self.model.create()
            }, label: {
                Text("Create")
            })
            
            Spacer()

        }
        .padding()
        .alert(isPresented: $model.showAlert) { () -> Alert in
            if model.alertType == .fail {
                return Alert(title: Text("Failed to create"),
                             message: Text("Some fields aren't filled in or you don't have internet access. Error: \(self.model.errorDetail)"),
                             dismissButton: .destructive(Text("Okay")) {
                                self.model.showAlert = false
                             })
            }
            else { // success
                return Alert(title: Text("Success!"),
                             message: Text("This goal has been successfully created!"),
                             dismissButton: .default(Text("Okay")) {
                                self.present = false
                                self.model.showAlert = false
                             })
            }
        }
    }
}

struct NewGoalViewPreviews: View {
    
    @State var present: Bool = true
    
    var body: some View {
        NewGoalView(present: $present)
    }
    
}

struct NewGoalView_Previews: PreviewProvider {

    @State var present: Bool = true

    static var previews: some View {
        NewGoalViewPreviews()
    }
}
