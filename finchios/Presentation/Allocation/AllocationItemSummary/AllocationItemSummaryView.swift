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
        Text("Hello, World!")
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