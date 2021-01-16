//
//  RecurringEditView.swift
//  finchios
//
//  Created by Brett Fazio on 1/15/21.
//

import SwiftUI
import OpenAPIClient

struct RecurringEditView: View {
    
    @Binding var present: Bool
    
    @Binding var type: RecurringItemType
    
    @Binding var recurring: Recurring
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Button {
                self.present = false
            } label: {
                Text("Save Edit")
            }

            
        }
    }
}

//struct RecurringEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecurringEditView()
//    }
//}
