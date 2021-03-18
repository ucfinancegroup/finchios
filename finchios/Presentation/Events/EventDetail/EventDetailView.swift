//
//  EventDetailView.swift
//  finchios
//
//  Created by Brett Fazio on 2/23/21.
//

import SwiftUI
import OpenAPIClient

struct EventDetailView: View {
    
    @Binding var shouldPop: Bool
    
    @State var event: Event
    
    @State var modalActive: Bool = false
    
    @StateObject var model = EventDetailModel()
    
    var body: some View {
        VStack {
            Text("bleh")
            
            Spacer()
            
            Button(action: {
                self.model.delete(id: self.event.id!.oid)
            }, label: {
                HStack {
                    Spacer()
                    Text("Delete")
                    Spacer()
                }
                .padding()
                .bubble(.red)
                .foregroundColor(.white)
            })
        }
        .onAppear() {
            model.setup(event: event)
        }
        .navigationBarTitle(event.name.count > 0 ? event.name : "Unnamed Event")
//        .navigationBarItems(trailing:
//                                Button(action: {
//                                    self.modalActive = true
//                                }, label: {
//                                    Text("Edit")
//                                })
//                                .sheet(isPresented: $modalActive, onDismiss: {
//
//                                }, content: {
//                                    // Have edit?
//                                    //AllocationEditView(present: $modalActive, allocation: $event)
//                                }))
        .alert(isPresented: $model.showAlert) { () -> Alert in
            if model.showError {
                return Alert(title: Text("Failed to delete"),
                             message: Text("Failed to delete the allocation. Error: \(self.model.errorString)"),
                             dismissButton: .destructive(Text("Okay")) {
                                self.model.showAlert = false
                                self.model.showError = false
                                
                             })
            }
            else { // success
                return Alert(title: Text("Success!"),
                             message: Text("This allocation has been successfully deleted."),
                             dismissButton: .default(Text("Okay")) {
                                self.model.showAlert = false
                                self.model.showError = false
                                self.shouldPop = false
                             })
            }
        }
    }
}

//struct EventDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetailView()
//    }
//}
