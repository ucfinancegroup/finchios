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
    
    @ObservedObject var model: NewRecurringModel
    
    public init(present: Binding<Bool>, type: Binding<RecurringItemType>) {
        self._present = present
        self._type = type
        self.model = NewRecurringModel(type: type.wrappedValue)
    }
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                Text("Create a new \(type.rawValue.lowercased())")
                    .font(.title2)
                
                Spacer()
                
                TextField("Name", text: self.$model.name)
                
                Spacer()
                
                DatePicker("Start", selection: self.$model.start)
                
                Spacer()
                
                DatePicker("End", selection: self.$model.end)
                
                Spacer()
                
                Group {
                    if self.type == .income {
                        
                        TextField("Amount", text: self.$model.amountField)
                            .keyboardType(.decimalPad)
                        
                    }else if self.type == .expense {
                        
                        HStack {
                            Text("-")
                            
                            TextField("Amount", text: self.$model.amountField)
                                .keyboardType(.decimalPad)
                        }
                        
                        
                    }else {
                        
                        HStack {
                            Text("-")
                            
                            TextField("Principal", text: self.$model.principalField)
                                .keyboardType(.numberPad)
                        }
                        
                        
                        Spacer()
                        
                        TextField("Interest (Percent)", text: self.$model.interestField)
                            .keyboardType(.numberPad)
                        
                    }
                    
                    Picker("Interval", selection: self.$model.typ) {
                        ForEach(RecurringIntervalType.allCases, id: \.id) { type in
                            Text(type.rawValue.capitalized)
                        }
                    }
                    
                    Spacer()
                    
                    TextField("Interval Frequency", text: self.$model.freqContentField)
                        .keyboardType(.numberPad)
                    
                    Spacer()
                }
                
                Group {
                    Button(action: {
                        self.model.create()
                        UIApplication.shared.endEditing()
                    }, label: {
                        Text("Create")
                    })
                    
                    Spacer()
                }
                
            }
            .padding()
            .alert(isPresented: $model.showAlert) { () -> Alert in
                if model.showError {
                    return Alert(title: Text("Failed to create"),
                                 message: Text("Some fields aren't filled in or you don't have internet access. Error: \(self.model.errorString)"),
                                 dismissButton: .destructive(Text("Okay")) {
                                    self.model.showError = false
                                 })
                }
                else { // success
                    return Alert(title: Text("Success!"),
                                 message: Text("This \(self.type.rawValue) has been successfully created!"),
                                 dismissButton: .default(Text("Okay")) {
                                    self.present = false
                                    self.model.showError = false
                                 })
                }
            }
        }
    }
}

struct NewRecurringViewPreviews: View {
    
    @State var present: Bool = true
    @State var type: RecurringItemType = .income
    
    var body: some View {
        NewRecurringView(present: $present, type: $type)
    }
    
}

struct NewRecurringView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecurringViewPreviews()
    }
}
