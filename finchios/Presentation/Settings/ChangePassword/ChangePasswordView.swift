//
//  ChangePasswordView.swift
//  finchios
//
//  Created by Brett Fazio on 2/24/21.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @StateObject var model = ChangePasswordModel()
    
    var body: some View {
        VStack {
            
            SecureField("New Password", text: $model.newPassword)
                .padding()
            
            Spacer()
                .frame(height: 50)
            
            SecureField("Confirm New Password", text: $model.confirmPassword)
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
            if model.type == .notEqual {
                return Alert(title: Text("Passwords do not match"),
                             message: Text("The two passwords you entered do not match. Please confirm what was typed."),
                             dismissButton: .default(Text("Okay")) {
                                self.model.showAlert = false
                             })
            }
            else if model.type == .success { // success
                return Alert(title: Text("Success!"),
                             message: Text("Your password has been successfully changed."),
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

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
