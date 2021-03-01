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
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(model.allocations, id: \.id) { alloc in
                    AllocationItemSummaryView(allocation: alloc.obj, navAble: true)
                        .padding()
                        .bubble()
                }
            }
        }
        .onAppear() {
            self.isActive = false
            model.onAppear()
        }
        .navigationTitle(Text("Simulated Events"))
    }
}

struct AllocationView_Previews: PreviewProvider {
    static var previews: some View {
        AllocationView()
    }
}
