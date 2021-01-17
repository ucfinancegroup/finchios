//
//  NewGoalView.swift
//  finchios
//
//  Created by Brett Fazio on 1/16/21.
//

import SwiftUI

struct NewGoalView: View {
    
    @Binding var present: Bool
    
    @ObservedObject var model = NewGoalViewModel()
    
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .alert(isPresented: $model.showAlert) { () -> Alert in
            if model.alertType == .fail {
                return Alert(title: Text("Failed to create"),
                             message: Text("Some fields aren't filled in or you don't have internet access. Error: \(self.model.errorDetail)"),
                             dismissButton: .destructive(Text("Okay")) {
                                self.model.showAlert = false
                             })
            }
            else { // success
                return Alert(title: Text("Success!"),
                             message: Text("This goal has been successfully created!"),
                             dismissButton: .default(Text("Okay")) {
                                self.present = false
                                self.model.showAlert = false
                             })
            }
        }
    }
}

//struct NewGoalView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewGoalView()
//    }
//}
