//
//  AllocationDetailView.swift
//  finchios
//
//  Created by Brett Fazio on 3/1/21.
//

import SwiftUI
import OpenAPIClient

struct AllocationDetailView: View {
    
    @Binding var shouldPop: Bool
    
    @State var allocation: Allocation
    
    @State var modalActive: Bool = false
    
    @StateObject var model: AllocationDetailModel = AllocationDetailModel()
    
    private let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MM/dd/yyyy"
        return f
    }()
    
    var body: some View {
        VStack {
            Text("Beginning \(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(allocation.date))))")
                .font(.title3)
            
            PieView(entries: model.allocationConfiguration, legendEnabled: true)
                .frame(height: 300)
            
            Spacer()
            
            Button(action: {
                self.model.delete(id: self.allocation.id.oid)
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
            model.setup(alloc: allocation)
        }
        .navigationBarTitle("\(self.allocation.description)")
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.modalActive = true
                                }, label: {
                                    Text("Edit")
                                })
                                .sheet(isPresented: $modalActive, content: {
                                    AllocationEditView(present: $modalActive, allocation: $allocation)
                                }))
    }
}

struct AllocationDetailViewPreview: View {
    
    @State var pop = false
    
    var body: some View {
        AllocationDetailView(shouldPop: $pop, allocation: .dummy)
    }
    
}

struct AllocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AllocationDetailViewPreview()
    }
}
