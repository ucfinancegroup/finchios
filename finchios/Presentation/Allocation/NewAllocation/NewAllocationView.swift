//
//  NewAllocationView.swift
//  finchios
//
//  Created by Brett Fazio on 3/1/21.
//

import SwiftUI

struct NewAllocationView: View {
    
    @Binding var present: Bool
    
    var body: some View {
        VStack {
            Text("Add a new event")
                .font(.title2)
                .padding()
            
            
        }
    }
}

struct NewAllocationViewPreview: View {
    
    @State var present = true
    
    var body: some View {
        NewAllocationView(present: $present)
    }
    
}

struct NewAllocationView_Previews: PreviewProvider {
    static var previews: some View {
        NewAllocationViewPreview()
    }
}
