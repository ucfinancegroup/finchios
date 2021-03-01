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
    
    @StateObject var model: RecurringDetailViewModel = RecurringDetailViewModel()
    
    var body: some View {
        VStack {
            Text("Hello")
        }
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
