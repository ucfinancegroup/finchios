//
//  AllocationView.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import SwiftUI

struct AllocationSummaryView: View {
    
    @StateObject var model: AllocationSummaryViewModel = AllocationSummaryViewModel()
    
    var body: some View {
        VStack {
            PieView(entries: model.allocationConfiguration)
        }.onAppear() {
            model.onAppear()
        }
        
    }
}

struct AllocationSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AllocationSummaryView()
    }
}
