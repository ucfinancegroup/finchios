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
    
    @State var allocationConfiguration: [PieChartDataEntry]
    
    private let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MM/dd/yyyy"
        return f
    }()
    
    public init(newAllocation: Allocation, newNavAble: Bool) {
        _allocation = .init(initialValue: newAllocation)
        _navAble = .init(initialValue: newNavAble)
        var config = newAllocation.schema.map { PieChartDataEntry(alloc: $0) }
        let cutoff = PieChartDataEntry.cutoff
        
        let smalls = config.filter({ $0.value < Double(cutoff) })
        
        config.removeAll { $0.value < Double(cutoff) }
        
        let sum = smalls.map({$0.value}).reduce(0, +)
        
        config.append( PieChartDataEntry(value: sum, label: "Other") )
        
        _allocationConfiguration = .init(initialValue: config)
    }
    
    
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
        .disabled(!navAble)
        .foregroundColor(.primary)
    }
    
    
}

struct AllocationItemSummaryPreviews: View {
    
    @State var alloc = Allocation.dummy

    var body: some View {
        AllocationItemSummaryView(newAllocation: alloc, newNavAble: false)
    }
    
}

struct AllocationItemSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AllocationItemSummaryPreviews()
    }
}
