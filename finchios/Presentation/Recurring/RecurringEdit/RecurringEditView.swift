//
//  RecurringEditView.swift
//  finchios
//
//  Created by Brett Fazio on 1/15/21.
//

import SwiftUI
import OpenAPIClient

struct RecurringEditView: View {
    
    @Binding var present: Bool
    
    @Binding var type: RecurringItemType
    
    @Binding var recurring: Recurring
    
    @State var model: RecurringEditViewModel = RecurringEditViewModel()
    
    var body: some View {
        VStack {
            
            Spacer()
            
            TextField("Name", text: self.$model.name)
            
            Spacer()
            
            DatePicker("Start", selection: self.$model.start)
            
            Spacer()
            
            DatePicker("End", selection: self.$model.end)
            
            Spacer()
            
            Group {
                if self.type == .income || self.type == .expense {
                    
                    TextField("Amount", text: self.$model.amountField)
                        .keyboardType(.numberPad)
                    
                }else {
                    
                    TextField("Principal", text: self.$model.principalField)
                        .keyboardType(.numberPad)
                    
                    Spacer()
                    
                    TextField("Interest (Percent)", text: self.$model.interestField)
                        .keyboardType(.numberPad)
                    
                }
                
                Picker("Interval", selection: self.$model.typ) {
                    ForEach(RecurringIntervalType.allCases) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                
                TextField("Interval Frequency", text: self.$model.freqContentField)
                    .keyboardType(.numberPad)
                
                Spacer()
            }
            
            Spacer()
            
            Button {
                self.present = false
            } label: {
                Text("Save Edit")
            }

            
        }
        .onAppear() {
            print("on appear")
            model = RecurringEditViewModel(recurring: recurring)
        }
        .alert(isPresented: $model.showAlert) { () -> Alert in
            if model.showError {
                return Alert(title: Text("Failed to edit"),
                             message: Text("Failed to edit the \(self.type.rawValue). Error: \(self.model.errorString)"),
                             dismissButton: .destructive(Text("Okay")) {
                                self.model.showAlert = false
                                self.model.showError = false
                                
                             })
            }
            else { // success
                return Alert(title: Text("Success!"),
                             message: Text("This \(self.type.rawValue) has been successfully edited."),
                             dismissButton: .default(Text("Okay")) {
                                self.present = false
                             })
            }
        }
    }
}

//struct RecurringEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecurringEditView()
//    }
//}
