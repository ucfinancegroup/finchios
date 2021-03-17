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
    
    var time: OverviewProjection
    
    public init(present: Binding<Bool>, type: Binding<RecurringItemType>, time: OverviewProjection) {
        self._present = present
        self._type = type
        self.model = NewRecurringModel(type: type.wrappedValue)
        self.time = time
    }
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                Text("Create a new \(type.rawValue.lowercased())")
                    .font(.title2)
                
                Spacer()
                
                TextField("Name", text: self.$model.name)
                
                Spacer()
                
                DatePicker("Start", selection: self.$model.start, displayedComponents: .date)
                
                Spacer()
                
                DatePicker("End", selection: self.$model.end, displayedComponents: .date)
                
                Spacer()
                
                Group {
                    if self.type == .income || self.type == .expense {
                        HStack {
                            
                            if self.type == .income {
                                Text("$")
                            }else {
                                Text("-$")
                            }
                            
                            
                            NumberField(text: $model.amountField, alignment: .natural, keyType: .decimalPad, placeholder: "Amount")
                            
                            Spacer()
                        }
                        
                    }else {
                        
                        HStack {
                            Text("-$")
                            
                            NumberField(text: $model.principalField, alignment: .natural, keyType: .decimalPad, placeholder: "Principal")
                        }
                        
                        
                        Spacer()
                        
                        NumberField(text: $model.interestField, alignment: .natural, keyType: .decimalPad, placeholder: "Interest (Percent)")
                        
                    }
                    
                    Spacer()
                    
                    Picker("Interval", selection: self.$model.typ) {
                        ForEach(RecurringIntervalType.allCases, id: \.id) { type in
                            Text(type.rawValue.capitalized)
                        }
                    }
                    
                    Spacer()
                    
                    NumberField(text: $model.freqContentField, alignment: .natural, keyType: .numberPad, placeholder: "Interval Frequency")
                    
                    Spacer()
                }
                
                Group {
                    Button(action: {
                        self.model.create(time: time)
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
        NewRecurringView(present: $present, type: $type, time: .overview)
    }
    
}

struct NewRecurringView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecurringViewPreviews()
    }
}
