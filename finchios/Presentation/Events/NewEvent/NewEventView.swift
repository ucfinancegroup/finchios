//
//  NewEventView.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import SwiftUI

struct NewEventView: View {
    
    @Binding var present: Bool
    
    @StateObject var model = NewEventModel()
    
    var body: some View {
        VStack {
            Text("Add a new event")
                .font(.title2)
                .padding()
            
            Divider()
            
            DatePicker("Start", selection: self.$model.start, displayedComponents: .date)
                .padding()
            
            Menu {
                ForEach(model.examples, id: \.id) { c in
                    Button(action: {
                        self.model.setSelected(event: c.obj)
                    }, label: {
                        Text(c.obj.name)
                    })
                }
            } label: {
                Text(model.event.name)
            }
            
            // Event information
            Group {
                
                
            }
            
            Spacer()
            
            Button(action: {
                self.model.create()
            }, label: {
                Text("Create")
                    .padding()
            })
        }
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

struct NewEventViewPreview: View {
    
    @State var bind = false
    
    var body: some View {
        NewEventView(present: $bind)
    }
    
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventViewPreview()
    }
}
