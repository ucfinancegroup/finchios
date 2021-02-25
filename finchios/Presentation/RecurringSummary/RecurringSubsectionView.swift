//
//  RecurringSummaryViewItem.swift
//  finchios
//
//  Created by Brett Fazio on 1/7/21.
//

import SwiftUI
import OpenAPIClient

struct RecurringSubsectionView: View {
    
    @State var type: RecurringItemType
    
    @State var time: OverviewProjection
    
    @Binding var recurrings: [Recurring]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(time == .projection ? "Future " : "")\(type.rawValue)s")
                    .font(.title)
                
                Spacer()
                
                NavigationLink(
                    destination: RecurringView(type: $type, time: time),
                    label: {
                        Image("RightArrow")
                    })

            }

            
            // Make sure there are indices.
            if recurrings.count > 0 {
                
                Divider()
                
                ForEach(recurrings.indices) { index in
                    if type == .debt {
                        PrincipalItemSummary(type: $type, recurring: recurrings[index], navAble: true, time: time)
                    }else {
                        AmountItemSummary(type: $type, recurring: recurrings[index], navAble: false, time: time)
                    }
                }
            }else {
                //TODO(): Display to the user that there is nothing of this type.
            }
            
        }
        .padding()
    }
}

struct RecurringSubsectionViewPreview: View {
    
    @State var type: RecurringItemType = .income
    
    @State var recurrings: [Recurring] = [.dummyIncome, .dummyIncome]
    
    var body: some View {
        RecurringSubsectionView(type: type, time: .overview, recurrings: $recurrings)
    }
    
}

struct RecurringSubsectionView_Previews: PreviewProvider {
    static var previews: some View {
        RecurringSubsectionViewPreview()
    }
}
