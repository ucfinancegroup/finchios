//
//  AccountView.swift
//  finchios
//
//  Created by Brett Fazio on 1/23/21.
//

import SwiftUI

struct AccountView: View {
    
    @State var isActive: Bool = false
    
    @ObservedObject var model: AcccountViewModel = AcccountViewModel()
    
    @State var modalCreate: Bool = false
    
    var body: some View {
            VStack {
                List {
                    ForEach(model.accounts, id: \.id) { account in
                        AccountItemSummary(account: account.account, navAble: true)
                            .padding()
                        
                    }
                    
                    if model.errors.count > 0 {
                        Text("Failed to fetch \(model.errors.count) accounts with errors: \(model.formatErrors())")
                    }
                }
            }
        .onAppear() {
            self.isActive = false
            model.onAppear()
        }
        .navigationTitle(Text("Goals"))
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.modalCreate = true
                                }, label: {
                                    Image("Plus")
                                })
                                .sheet(isPresented: self.$modalCreate, content: {
                                    NewGoalView(present: self.$modalCreate)
                                }))
        
    }
}

struct AccountViewProvider: View {

    var body: some View {
        AccountView()
    }
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountViewProvider()
    }
}
