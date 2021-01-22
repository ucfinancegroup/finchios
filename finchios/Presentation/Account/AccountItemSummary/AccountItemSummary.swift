//
//  AccountItemSummary.swift
//  finchios
//
//  Created by Brett Fazio on 1/22/21.
//

import SwiftUI
import OpenAPIClient

struct AccountItemSummary: View {
    
    @State var account: GoalAndStatus
    
    @State var isActive: Bool = false
    
    @State var navAble: Bool
    
    var body: some View {
        NavigationLink(destination: Text("to be AccountDetailView"), isActive: $isActive) {
            VStack(alignment: .leading) {
                HStack {
                    Text(account.goal.name)
                        .font(.title2)
                    
                    Spacer()
                }
                
                Text("$\(Double.formatOffset(amt: account.goal.threshold))")
            }
        }
        .disabled(!navAble)
        .foregroundColor(.primary)
    }
}

struct AccountItemSummary_Previews: PreviewProvider {
    static var previews: some View {
        AccountItemSummary(account: GoalAndStatus.dummy, navAble: false)
    }
}
