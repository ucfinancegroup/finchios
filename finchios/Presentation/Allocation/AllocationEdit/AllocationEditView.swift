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
            Text("Edit your allocation")
                .font(.title2)
                .padding()
            
            Divider()
            
            TextField("Name", text: $model.name)
                .padding()
            
            DatePicker("Start Date", selection: self.$model.date, displayedComponents: .date)
                .padding()
            
            HStack {
                
                Text("\(100-model.getSum())% Unallocated")
                
                Spacer()
                
                Button(action: {
                    self.model.newClass()
                }, label: {
                    Text("New Asset Type")
                })
            }
            .padding()
            
            ForEach(model.ids, id: \.self) { id in
                AllocationSliderView(id: id,
                                     value: $model.classes[unchecked: id].1,
                                     selection: $model.classes[unchecked: id].0,
                                     classTypes: $model.classTypes,
                                     model: model)
            }
            
            Spacer()
            
            Button(action: {
                self.model.edit(original: allocation)
            }, label: {
                HStack {
                    Spacer()
                    Text("Update")
                    Spacer()
                }
                .padding()
                .bubble(.teal)
                .foregroundColor(.white)
            })
            
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
                                
                                // Prop changes
                                self.allocation = self.model.getAllocationObject(original: self.allocation)

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
