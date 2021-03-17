//
//  AllocationItemSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import SwiftUI
import OpenAPIClient
import Charts

struct AllocationItemSummaryView: View {
    
    @State var allocation: Allocation
    
    @State var isActive: Bool = false
    
    @State var navAble: Bool
    
    @State var allocationConfiguration: [PieChartDataEntry] = [PieChartDataEntry(value: 1)]
    
    private let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MM/dd/yyyy"
        return f
    }()
    
    
    var body: some View {
        NavigationLink(destination: AllocationDetailView(shouldPop: $isActive, allocation: allocation), isActive: $isActive) {
            HStack {
                VStack(alignment: .leading) {
                    Text(allocation.description.count > 0 ? allocation.description : "Unnamed")
                        .font(.title2)
                    
                    Text(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(allocation.date))))
                    
                    Spacer()
                }
                .padding()
                
                Spacer()

                PieView(entries: allocationConfiguration, legendEnabled: false, naked: true)
                    .frame(height: 100)
                    .padding()
                
            }
            
        }
        .onAppear() {
            allocationConfiguration = allocation.schema.map { PieChartDataEntry(alloc: $0) }
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
