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
    
    @StateObject var model: RecurringEditViewModel = RecurringEditViewModel()
    
    @State var time: OverviewProjection
    
    var body: some View {
        VStack {
            let typ = model.typ.rawValue.capitalized == "Annually" ? "Annual" : model.typ.rawValue.capitalized
            
            Spacer()
            
            TextField("Name", text: self.$model.name).font(.largeTitle)
            
            Spacer()
            
            DatePicker("Start", selection: self.$model.start, displayedComponents: .date)
            
            
            DatePicker("End", selection: self.$model.end, displayedComponents: .date)
            
            Spacer()
            
            Group {
                if self.type == .income || self.type == .expense {
                    HStack {
                        
                        if self.type == .income {
                            Text("\(typ) Income: $")
                        }else {
                            Text("\(typ) Expense: -$")
                        }
                        
                        
                        NumberField(text: $model.amountField, alignment: .natural, keyType: .decimalPad, placeholder: "Amount")
                        
                        Spacer()
                    }
                    
                    
                }else {
                    
                    HStack {
                        
                        Text("\(typ) Debt -$")
                        
                        NumberField(text: $model.principalField, alignment: .natural, keyType: .decimalPad, placeholder: "Principal")
                        
                        Spacer()
                    }

                    
                    Spacer()
                    
                    NumberField(text: $model.interestField, alignment: .natural, keyType: .decimalPad, placeholder: "Interest (Percent)")
                    
                }
                
                Spacer()
                
                HStack {
                    Text("Occurs every ")
                    
                    NumberField(text: $model.freqContentField, alignment: .natural, keyType: .numberPad, placeholder: "Interval Frequency")
                    
                    Menu {
                        ForEach(model.types, id: \.id) { c in
                            Button(action: {
                                self.model.typ = c.obj
                            }, label: {
                                Text(self.model.convertTo(og: c.obj))
                            })
                        }
                    } label: {
                        Text(self.model.convertTo(og: self.model.typ))
                    }
                    

                    
                    Spacer()
                }
                

                Spacer()
            }
            
            Spacer()
            
            Button {
                self.model.edit(id: recurring.id!.oid, time: time, type: type)
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
                                
                                // Propogate changes
                                self.recurring = model.createPropObj(original: self.recurring, type: self.type)
                                
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

struct RecurringEditViewPreview: View {
    
    @State var present = true
    @State var type: RecurringItemType = .income
    @State var recurring: Recurring = .dummyIncome
    
    
    var body: some View {
        RecurringEditView(present: $present, type: $type, recurring: $recurring, time: .overview)
    }
    
}

struct RecurringEditView_Previews: PreviewProvider {
    static var previews: some View {
        RecurringEditViewPreview()
    }
}
