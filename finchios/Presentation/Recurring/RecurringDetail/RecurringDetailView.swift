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
    
    private let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MM/dd/yyyy"
        return f
    }()
    
    var body: some View {
        VStack {
            //TODO() Reload when a few modal was created to show the new item
            //Information
            
            HStack {
                Text("Starts \(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(recurring.start))))")
                    //.padding(.horizontal)
                
                Spacer()
            }
            .padding()
            
            HStack {
                Text("Ends \(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(recurring.end))))")
                    //.padding(.horizontal)
                
                Spacer()
            }.padding()
            
            Spacer()

            
            Group {                
                if type == .debt {
                    Text("$\(recurring.principal.format())")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Text("\(Double.format(amt: recurring.interest))% Interest")
                        .font(.title2)
                    
                    Spacer()
                        .frame(height: 30)
                }else { // income / expense

                    Text("$\(recurring.amount.format())")
                        .font(.largeTitle)
                        .foregroundColor(type == .income ? .green : .red)
                    
                    Spacer()
                        .frame(height: 30)
                }
                
                Text("Every \(recurring.frequency.content) \(FormatTyp.map[recurring.frequency.typ.rawValue]!)(s)")
                    .font(.headline)
                
                Spacer()
                

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
    @State var type: RecurringItemType = .debt
    
    var body: some View {
        NavigationView {
            RecurringDetailView(shouldPop: $pop, type: $type, recurring: .dummyDebt, time: .overview)
        }
    }
    
}

struct RecurringDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecurringDetailViewPreview()
    }
}
