//
//  AllocationEditView.swift
//  finchios
//
//  Created by Brett Fazio on 3/4/21.
//

import SwiftUI
import OpenAPIClient

struct AllocationEditView: View {
    
    @Binding var present: Bool
    
    @Binding var allocation: Allocation
    
    @StateObject var model: AllocationEditModel = AllocationEditModel()
    
    var body: some View {
        VStack {
            
        }
        // TODO(): Not showing because it is a modal sheet?
        .alert(isPresented: $model.showAlert) { () -> Alert in
            if model.showError {
                return Alert(title: Text("Failed to edit"),
                             message: Text("Failed to edit the allocation. Error: \(self.model.errorString)"),
                             dismissButton: .destructive(Text("Okay")) {
                                self.model.showAlert = false
                                self.model.showError = false

                             })
            }
            else { // success
                return Alert(title: Text("Success!"),
                             message: Text("This allocation has been successfully edited."),
                             dismissButton: .default(Text("Okay")) {
                                self.present = false
                             })
            }
        }
        .padding()
        .onAppear() {
            self.model.set(alloc: self.allocation)
        }
    }
}

struct AllocationEditViewPreview: View {
    
    @State var present: Bool = true
    @State var alloc = Allocation.dummy
    
    var body: some View {
        AllocationEditView(present: $present, allocation: $alloc)
    }
}

struct AllocationEditView_Previews: PreviewProvider {
    static var previews: some View {
        AllocationEditViewPreview()
    }
}
