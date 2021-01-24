//
//  AccountsSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import SwiftUI

struct AccountsSummaryView: View {
    
    @ObservedObject var model = AccountsSummaryViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Accounts")
                    .font(.title)
                
                Spacer()
                
                NavigationLink(
                    destination: AccountView(),
                    label: {
                        Image("RightArrow")
                    })
                
            }
            
            ForEach(model.accounts, id: \.id) { account in
                AccountItemSummary(account: account.account, navAble: false)
            }
        }
        .padding()
        .onAppear() {
            model.onAppear()
        }
    }
}

struct AccountsSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsSummaryView()
    }
}
