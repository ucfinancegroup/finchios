//
//  AllocationItemSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import SwiftUI
import OpenAPIClient

struct AllocationItemSummaryView: View {
    
    @State var allocation: Allocation
    
    @State var isActive: Bool = false
    
    @State var navAble: Bool
    
    var body: some View {
        NavigationLink(destination: AllocationDetailView(shouldPop: $isActive, allocation: allocation), isActive: $isActive) {
            VStack(alignment: .leading) {
                HStack {
                    Text(allocation.description)
                        .font(.title2)
                    
                    Spacer()
                }
                
                //TODO(): Add how many times annually
                //Text("\(self.type.rawValue) of $\(recurring.amount.format()) \(recurring.frequency.typ.rawValue)")
            }
        }
        .disabled(!navAble)
        .foregroundColor(.primary)
    }
}

struct AllocationItemSummaryPreviews: View {
    
    @State var alloc = Allocation.dummy

    var body: some View {
        AllocationItemSummaryView(allocation: alloc, navAble: false)
    }
    
}

struct AllocationItemSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AllocationItemSummaryPreviews()
    }
}
