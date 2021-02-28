//
//  ChangeFinancials.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import SwiftUI

struct ChangeFinancials: View {
    
    @StateObject var model = ChangeFinancialsModel()
    
    var body: some View {
        VStack {
            
            NumberField(alignment: .natural, keyType: .decimalPad, placeholder: "Income") { (change) in
                self.model.income = change
            }
                .padding()
            
            Spacer()
            
            Button(action: {
                self.model.changedTapped()
            }) {
                Text("Change Financials")
                    .padding()
                    .bubble(.teal)
                    .foregroundColor(.white)
            }
            
        }
        .navigationTitle("Change Financials")
        .alert(isPresented: $model.showAlert) { () -> Alert in
            
            if model.type == .invalid {
                return Alert(title: Text("Invalid input"),
                             message: Text("Could not parse the number entered. Please ensure it is non-empty and only contains digits."),
                             dismissButton: .default(Text("Okay")) {
                                self.model.showAlert = false
                             })
            }
            else if model.type == .empty {
                return Alert(title: Text("Income cannot be empty"),
                             message: Text("The income you entered was empty. Please ensure it is non-empty and try again."),
                             dismissButton: .default(Text("Okay")) {
                                self.model.showAlert = false
                             })
            }
            else if model.type == .success { // success
                return Alert(title: Text("Success!"),
                             message: Text("Your financial information has been successfully changed."),
                             dismissButton: .default(Text("Okay")) {
                                self.model.showAlert = false
                             })
            }
            else {//if model.type == .server {
                return Alert(title: Text("A server error occured."),
                             message: Text("Please ensure you have a valid internet connection and try again."),
                             dismissButton: .default(Text("Okay")) {
                                self.model.showAlert = false
                             })
            }
        }
    }
}

struct ChangeFinancials_Previews: PreviewProvider {
    static var previews: some View {
        ChangeFinancials()
    }
}
