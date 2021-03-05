//
//  NewAllocationView.swift
//  finchios
//
//  Created by Brett Fazio on 3/1/21.
//

import SwiftUI

struct NewAllocationView: View {
    
    @Binding var present: Bool
    
    @StateObject var model = NewAllocationModel()
    
    var body: some View {
        VStack {
            Text("Add a new allocation")
                .font(.title2)
                .padding()
            
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.model.newClass()
                }, label: {
                    Text("New")
                })
            }
            
            ForEach(model.classes.indices) { index in
                AllocationSliderView(value: $model.classes[index].1,
                                     selection: $model.classes[index].0,
                                     classTypes: $model.classTypes,
                                     model: model)
            }
        }
        .padding()
        .alert(isPresented: $model.showAlert) { () -> Alert in
            if model.showError {
                return Alert(title: Text("Failed to create"),
                             message: Text("Some fields aren't filled in or you don't have internet access. Error: \(self.model.errorString)"),
                             dismissButton: .destructive(Text("Okay")) {
                                self.model.showError = false
                             })
            }
            else { // success
                return Alert(title: Text("Success!"),
                             message: Text("This allocation has been successfully created!"),
                             dismissButton: .default(Text("Okay")) {
                                self.present = false
                                self.model.showError = false
                             })
            }
        }
    }
}

struct NewAllocationViewPreview: View {
    
    @State var present = true
    
    var body: some View {
        NewAllocationView(present: $present)
    }
    
}

struct NewAllocationView_Previews: PreviewProvider {
    static var previews: some View {
        NewAllocationViewPreview()
    }
}
