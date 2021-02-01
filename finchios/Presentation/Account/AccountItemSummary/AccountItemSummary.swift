//
//  AccountItemSummary.swift
//  finchios
//
//  Created by Brett Fazio on 1/22/21.
//

import SwiftUI
import OpenAPIClient

struct AccountItemSummary: View {
    
    @State var account: Account
    
    @State var isActive: Bool = false
    
    @State var navAble: Bool
    
    var body: some View {
        NavigationLink(destination: AccountDetailView(shouldPop: $isActive, account: AccountIdentifiable(account: account)), isActive: $isActive) {
            VStack(alignment: .leading) {
                HStack {
                    Text(account.name)
                        .font(.title2)
                    
                    Spacer()
                }
                
                Text("$\((Double(account.balance)).format())")
            }
        }
        .disabled(!navAble)
        .foregroundColor(.primary)
    }
}

struct AccountItemSummary_Previews: PreviewProvider {
    static var previews: some View {
        AccountItemSummary(account: Account.dummy, navAble: false)
    }
}
