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
    
    @Binding var recurring: Recurring
    
    @ObservedObject var model: RecurringDetailViewModel = RecurringDetailViewModel()
    
    var body: some View {
        VStack {
            
            Text(recurring.name)
            
            Spacer()
            
            Button(action: {
                self.model.delete(id: self.recurring.id.oid)
            }, label: {
                Text("Delete")
            })
            
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
