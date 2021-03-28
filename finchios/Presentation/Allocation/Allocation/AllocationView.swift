//
//  AllocationView.swift
//  finchios
//
//  Created by Brett Fazio on 2/23/21.
//

import SwiftUI

struct AllocationView: View {
    
    // I think this is useless atm, at one point was used to prevent fetching again?
    @State var isActive: Bool = false
    
    @StateObject var model = AllocationModel()
    
    @State var modalCreate: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(model.allocations, id: \.id) { alloc in
                    AllocationItemSummaryView(newAllocation: alloc.obj, newNavAble: true)
                        .padding()
                        .bubble()
                }
            }
        }
        .onAppear() {
            self.isActive = false
            model.onAppear()
        }
        .navigationTitle(Text("Allocations"))
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.modalCreate = true
                                }, label: {
                                    Image("Plus")
                                })
                                .sheet(isPresented: self.$modalCreate, onDismiss: {
                                    model.onAppear()
                                }, content: {
                                    NewAllocationView(present: self.$modalCreate)
                                }))
    }
}

struct AllocationView_Previews: PreviewProvider {
    static var previews: some View {
        AllocationView()
    }
}
