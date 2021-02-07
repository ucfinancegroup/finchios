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

                Text("Balance of $\((Double(account.account.balance)).format())")
                
                Spacer()
            }
            
            Spacer()
            
            Button(action: {
                self.model.delete(id: self.account.account.itemId)
            }, label: {
                HStack {
                    Spacer()
                    Text("Delete ALL accounts from this institution.")
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                    .padding()
                    .bubble(.red)
                    .foregroundColor(.white)
            })
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

struct AccountDetailViewPreview: View {
    
    @State var pop = false
    var body: some View {
        AccountDetailView(shouldPop: $pop, account: .init(account: .dummy))
    }
    
}

struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailViewPreview()
    }
}
