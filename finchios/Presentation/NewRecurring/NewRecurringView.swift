//
//  NewRecurringView.swift
//  finchios
//
//  Created by Brett Fazio on 1/11/21.
//

import SwiftUI

struct NewRecurringView: View {
    
    @Binding var type: RecurringItemType
    
    @ObservedObject var model = NewRecurringModel()
    
    var body: some View {
        
        VStack {
            
            TextField("Name", text: self.$model.name)
            
            Spacer()
            
            DatePicker("Start", selection: self.$model.start)
            
            DatePicker("End", selection: self.$model.end)
            
            Group {
                if self.type == .income || self.type == .expense {
                    
                    TextField("Amount", text: self.$model.amountField)
                        .keyboardType(.numberPad)
                    
                }else {
                    
                    TextField("Principal", text: self.$model.principalField)
                        .keyboardType(.numberPad)
                    
                    TextField("Interest (Percent)", text: self.$model.interestField)
                        .keyboardType(.numberPad)
                    
                }
            }

            
            Button(action: {
                self.model.create()
            }, label: {
                Text("Create")
            })
            
        }
    }
}

//struct NewRecurringView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewRecurringView()
//    }
//}
