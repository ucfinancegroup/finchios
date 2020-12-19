//
//  AllocationView.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import SwiftUI

struct AllocationView: View {
    
    @ObservedObject var model: AllocationViewModel = AllocationViewModel()
    
    var body: some View {
        VStack {
            PieView(entries: model.allocationConfiguration)
        }.onAppear() {
            model.onAppear()
        }
        
    }
}

struct AllocationView_Previews: PreviewProvider {
    static var previews: some View {
        AllocationView()
    }
}
