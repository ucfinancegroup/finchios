//
//  AllocationEditView.swift
//  finchios
//
//  Created by Brett Fazio on 3/4/21.
//

import SwiftUI
import OpenAPIClient

struct AllocationEditView: View {
    
    @Binding var present: Bool
    
    @Binding var allocation: Allocation
    
    @StateObject var model: AllocationEditModel = AllocationEditModel()
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct AllocationEditViewPreview: View {
    
    @State var present: Bool = true
    @State var alloc = Allocation.dummy
    
    var body: some View {
        AllocationEditView(present: $present, allocation: $alloc)
    }
}

struct AllocationEditView_Previews: PreviewProvider {
    static var previews: some View {
        AllocationEditViewPreview()
    }
}
