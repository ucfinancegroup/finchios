//
//  AccountDetailView.swift
//  finchios
//
//  Created by Brett Fazio on 1/23/21.
//

import SwiftUI

struct AccountDetailView: View {
    
    @Binding var shouldPop: Bool
    
    @State var account: AccountIdentifiable
    
    @State var modalActive: Bool = false
    
    @ObservedObject var model = AccountDetailViewModel()
    
    var body: some View {
        VStack {
            
            //Information
            Group {
                Text(account.account.name)
                
                Spacer()
                    .frame(height: 30)

                Text("Balance of $\((account.account.balance / 100).format())")
                
                Spacer()
            }
            
            Spacer()
            
            Button(action: {
                self.model.delete(id: self.account.account.itemId)
            }, label: {
                Text("Delete")
                    .foregroundColor(.red)
            })
            
            Spacer()
            
        }
        .padding()
        .alert(isPresented: $model.showAlert) { () -> Alert in
            if model.showError {
                return Alert(title: Text("Failed to delete"),
                             message: Text("Failed to delete the goal. Error: \(self.model.errorString)"),
                             dismissButton: .destructive(Text("Okay")) {
                                self.model.showAlert = false
                                self.model.showError = false
                                
                             })
            }
            else { // success
                return Alert(title: Text("Success!"),
                             message: Text("This goal has been successfully deleted."),
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
