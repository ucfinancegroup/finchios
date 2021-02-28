//
//  ChangeName.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import SwiftUI

struct ChangeName: View {
    
    @StateObject var model = ChangeNameModel()
    
    var body: some View {
        VStack {
            
            TextField("First Name", text: $model.first)
                .padding()
            
            Spacer()
                .frame(height: 50)
            
            TextField("Last Name", text: $model.last)
                .padding()
            
            Spacer()
            
            Button(action: {
                self.model.changedTapped()
            }) {
                Text("Change Password")
                    .padding()
                    .bubble(.teal)
                    .foregroundColor(.white)
            }
            
        }
        .navigationTitle("Change Password")
        .alert(isPresented: $model.showAlert) { () -> Alert in
            if model.type == .empty {
                return Alert(title: Text("Names cannot be empty"),
                             message: Text("One or both of then names you entered was empty. Please ensure that both are non-empty and try again."),
                             dismissButton: .default(Text("Okay")) {
                                self.model.showAlert = false
                             })
            }
            else if model.type == .success { // success
                return Alert(title: Text("Success!"),
                             message: Text("Your personal info has been successfully changed."),
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

struct ChangeName_Previews: PreviewProvider {
    static var previews: some View {
        ChangeName()
    }
}
