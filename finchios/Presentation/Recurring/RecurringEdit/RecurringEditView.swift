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
    
    @ObservedObject var model: RecurringEditViewModel = RecurringEditViewModel()
    
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
                    HStack {
                        
                        if self.type == .income {
                            Text("$")
                        }else {
                            Text("-$")
                        }
                        
                        
                        NumberField(text: self.$model.amountField, keyType: .decimalPad, placeholder: "Amount") { (change) in
                            self.model.amountField = change
                        }
                        
                        Spacer()
                    }
                    
                    
                }else {
                    
                    HStack {
                        
                        Text("-$")
                        
                        NumberField(text: self.$model.principalField, keyType: .decimalPad, placeholder: "Principal") { (change) in
                            self.model.principalField = change
                        }
                        
                        Spacer()
                    }

                    
                    Spacer()
                    
                    NumberField(text: self.$model.interestField, keyType: .decimalPad, placeholder: "Interest (Percent)") { (change) in
                        self.model.interestField = change
                    }
                    
                }
                
                NumberField(text: self.$model.freqContentField, keyType: .numberPad, placeholder: "Interval Frequency") { (change) in
                    self.model.freqContentField = change
                }
                
                TextField("Interval Frequency", text: self.$model.freqContentField)
                    .keyboardType(.numberPad)
                
                Spacer()
            }
            
            Spacer()
            
            Button {
                self.model.edit(id: recurring.id.oid)
                UIApplication.shared.endEditing()
            } label: {
                Text("Save Edit")
            }

            
        }
        // TODO(): Not showing because it is a modal sheet?
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
        .padding()
        .onAppear() {
            self.model.set(recurring: self.recurring)
        }

    }
}

//struct RecurringEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecurringEditView()
//    }
//}
