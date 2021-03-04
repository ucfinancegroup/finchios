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
            HStack {
                
                Text("Portfolio Allocation")
                    .font(.title)
                
                Spacer()
                
                NavigationLink(
                    destination: AllocationView(),
                    label: {
                        Image("RightArrow")
                    })
                
            }
            PieView(entries: model.allocationConfiguration, legendEnabled: true)
                .frame(height: 300)
        }
        .padding()
        .onAppear() {
            model.onAppear()
        }
        
    }
}

struct AllocationSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AllocationSummaryView()
    }
}
