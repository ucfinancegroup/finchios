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
        Text("accounts")
    }
}

struct AccountsSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsSummaryView()
    }
}
