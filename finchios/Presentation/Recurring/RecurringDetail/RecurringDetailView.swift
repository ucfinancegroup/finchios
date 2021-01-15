//
//  RecurringDetailView.swift
//  finchios
//
//  Created by Brett Fazio on 1/14/21.
//

import SwiftUI
import OpenAPIClient

struct RecurringDetailView: View {
    
    @Binding var shouldPop: Bool
    
    @Binding var type: RecurringItemType
    
    @State var recurring: Recurring
    
    @ObservedObject var model: RecurringDetailViewModel = RecurringDetailViewModel()
    
    var body: some View {
        VStack {
            
            //Information
            Group {
                Text(recurring.name)
                
                Spacer()
                    .frame(height: 30)
                
                if type == .debt {
                    Text("Principal amount of $\(Double.formatOffset(amt: recurring.principal))")
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Text("Interest of \(Double.format(amt: recurring.interest))")
                    
                    Spacer()
                        .frame(height: 30)
                }else { // income / expense
                    Text("Value of $\(Double.formatOffset(amt: recurring.amount))")
                    
                    Spacer()
                        .frame(height: 30)
                }
                
                Text("Occurs every \(recurring.frequency.content) \(FormatTyp.map[recurring.frequency.typ.rawValue]!)(s)")
            }
            
            Spacer()
            
            Button(action: {
                self.model.delete(id: self.recurring.id.oid)
            }, label: {
                Text("Delete")
                    .foregroundColor(.red)
            })
            
            Spacer()
            
        }
        .alert(isPresented: $model.showAlert) { () -> Alert in
            if model.showError {
                return Alert(title: Text("Failed to delete"),
                             message: Text("Failed to delete the \(self.type.rawValue). Error: \(self.model.errorString)"),
                             dismissButton: .destructive(Text("Okay")) {
                                self.model.showAlert = false
                                self.model.showError = false
                                
                             })
            }
            else { // success
                return Alert(title: Text("Success!"),
                             message: Text("This \(self.type.rawValue) has been successfully deleted."),
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

//struct RecurringDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecurringDetailView()
//    }
//}
