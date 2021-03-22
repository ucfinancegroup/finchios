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
    
    @StateObject var model = AccountDetailViewModel()
    
    var body: some View {
        VStack {
            
            //Information
            Group {

                Text("Balance of $\((Double(account.account.balance)).format())")
                    .font(.headline)
                
                Spacer()
            }
            
            Spacer()
            
            Button(action: {
                self.model.delete(item: self.account.account)
            }, label: {
                HStack {
                    Spacer()
                    Text("Delete")
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                    .padding()
                    .bubble(.red)
                    .foregroundColor(.white)
            })
        }
        .padding()
        .navigationTitle(Text(account.account.name))
        .alert(isPresented: $model.showAlert) { () -> Alert in
            if model.showError {
                return Alert(title: Text("Failed to hide"),
                             message: Text("Failed to hide the account. Error: \(self.model.errorString)"),
                             dismissButton: .destructive(Text("Okay")) {
                                self.model.showAlert = false
                                self.model.showError = false
                                
                             })
            }
            else { // success
                return Alert(title: Text("Success!"),
                             message: Text("This account has been successfully hid."),
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
        NavigationView {
            AccountDetailView(shouldPop: $pop, account: .init(account: .dummy))
        }
        
    }
    
}

struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailViewPreview()
    }
}
