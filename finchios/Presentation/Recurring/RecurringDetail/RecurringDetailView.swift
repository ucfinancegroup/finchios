//
//  RecurringDetailView.swift
//  finchios
//
//  Created by Brett Fazio on 1/14/21.
//

import SwiftUI
import OpenAPIClient

struct RecurringDetailView: View {
    
    @Binding var type: RecurringItemType
    
    @Binding var recurring: Recurring
    
    @ObservedObject var model: RecurringDetailViewModel = RecurringDetailViewModel()
    
    var body: some View {
        VStack {
            
            Text(recurring.name)
            
            Spacer()
            
            Button(action: {
                self.model.delete(id: self.recurring.id.oid)
            }, label: {
                Text("Delete")
            })
            
        }
        
    }
}

//struct RecurringDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecurringDetailView()
//    }
//}
