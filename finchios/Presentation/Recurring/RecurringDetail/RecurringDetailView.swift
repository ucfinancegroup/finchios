//
//  RecurringDetailView.swift
//  finchios
//
//  Created by Brett Fazio on 1/14/21.
//

import SwiftUI
import OpenAPIClient

struct RecurringDetailView: View {
    
    @Binding var shouldPop: Bool
    
    @Binding var type: RecurringItemType
    
    @State var recurring: Recurring
    
    @State var modalActive: Bool = false
    
    @StateObject var model: RecurringDetailViewModel = RecurringDetailViewModel()
    
    @State var time: OverviewProjection
    
    var body: some View {
        VStack {
            //TODO() Reload when a few modal was created to show the new item
            //Information
            Group {                
                if type == .debt {
                    Text("Principal amount of $\(recurring.principal.format())")
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Text("Interest of \(Double.format(amt: recurring.interest))")
                    
                    Spacer()
                        .frame(height: 30)
                }else { // income / expense
                    Text("Value of $\(recurring.amount.format())")
                    
                    Spacer()
                        .frame(height: 30)
                }
                
                Text("Occurs every \(recurring.frequency.content) \(FormatTyp.map[recurring.frequency.typ.rawValue]!)(s)")
                
                Spacer()
                
                Text("Begins on \(Date(timeIntervalSince1970: TimeInterval(recurring.start))) and ends \(Date(timeIntervalSince1970: TimeInterval(recurring.end)))")
            }
            
            Spacer()
            
            Button(action: {
                self.model.delete(id: self.recurring.id!.oid, time: time)
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
        .padding()
        .navigationBarTitle("\(self.recurring.name)")
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.modalActive = true
                                }, label: {
                                    Text("Edit")
                                })
                                .sheet(isPresented: $modalActive, content: {
                                    RecurringEditView(present: $modalActive, type: $type, recurring: $recurring, time: time)
                                }))
        .alert(isPresented: $model.showAlert) { () -> Alert in
            if model.showError {
                return Alert(title: Text("Failed to delete"),
                             message: Text("Failed to delete the \(self.type.rawValue). Error: \(self.model.errorString)"),
                             dismissButton: .destructive(Text("Okay")) {
                                self.model.showAlert = false
                                self.model.showError = false
                                
                             })
            }
            else { // success
                return Alert(title: Text("Success!"),
                             message: Text("This \(self.type.rawValue) has been successfully deleted."),
                             dismissButton: .default(Text("Okay")) {
                                //self.present = false
                                self.model.showAlert = false
                                self.model.showError = false
                                self.shouldPop = false
                             })
            }
        }
        
    }
}

struct RecurringDetailViewPreview: View {
    
    @State var pop = false
    @State var type: RecurringItemType = .income
    
    var body: some View {
        
        RecurringDetailView(shouldPop: $pop, type: $type, recurring: .dummyIncome, time: .overview)
    }
    
}

struct RecurringDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecurringDetailViewPreview()
    }
}
