//
//  NewRecurringView.swift
//  finchios
//
//  Created by Brett Fazio on 1/11/21.
//

import SwiftUI

struct NewRecurringView: View {
    
    @Binding var present: Bool
    
    @Binding var type: RecurringItemType
    
    @ObservedObject var model = NewRecurringModel()
    
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
            
            Button(action: {
                self.model.create()
            }, label: {
                Text("Create")
            })
            
            Spacer()
            
        }
        .padding()
        .alert(isPresented: $model.showError) { () -> Alert in
                return Alert(title: Text("Failed to create"),
                             message: Text("All fields are filled in and you have internet access. Error: \(self.model.errorString)"),
                             dismissButton: .destructive(Text("Okay")) {
                                self.model.showError = false
                             })
        }
        .alert(isPresented: $model.showSuccess, content: {
                return Alert(title: Text("Success!"),
                             message: Text("This \(self.type.rawValue) has been successfully created!"),
                             dismissButton: .default(Text("Okay")) {
                                self.present = false
                                self.model.showError = false
                             })
        })
    }
}

//struct NewRecurringView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewRecurringView()
//    }
//}
