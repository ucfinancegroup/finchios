//
//  NewAllocationView.swift
//  finchios
//
//  Created by Brett Fazio on 3/1/21.
//

import SwiftUI
import OpenAPIClient

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
            
            ForEach(model.ids, id: \.self) { id in
                AllocationSliderView(id: id,
                                     value: $model.classes[unchecked: id].1,
                                     selection: $model.classes[unchecked: id].0,
                                     classTypes: $model.classTypes,
                                     model: model)
            }
            
            DatePicker("Start Date", selection: self.$model.date)
            
            Spacer()
            
            Button(action: {
                self.model.create()
            }, label: {
                Text("Create")
            })
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

extension Dictionary where Key == UUID, Value == (Iden<AssetClassAndApy>, Iden<Double>) {
    subscript(unchecked key: Key) -> Value {
        get {
            guard let result = self[key] else {
                // Return temp dummy
                return (Iden<AssetClassAndApy>(obj: .init(_class: .init(typ: .cash), apy: 0)), Iden<Double>(obj: 0))
                //fatalError("This person does not exist.")
            }
            return result
        }
        set {
            self[key] = newValue
        }
    }
}
