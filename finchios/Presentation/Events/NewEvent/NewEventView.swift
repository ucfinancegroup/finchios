//
//  NewEventView.swift
//  finchios
//
//  Created by Brett Fazio on 2/28/21.
//

import SwiftUI

struct NewEventView: View {
    
    @Binding var present: Bool
    
    @StateObject var model = NewEventModel()
    
    var body: some View {
        VStack {
            Text("Create a new event")
                .font(.title2)
            
            Group {
                
            }
            
            Spacer()
            
            Button(action: {
                self.model.create()
            }, label: {
                Text("Create")
            })
            
            Spacer()
        }
    }
}

struct NewEventViewPreview: View {
    
    @State var bind = false
    
    var body: some View {
        NewEventView(present: $bind)
    }
    
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventViewPreview()
    }
}
