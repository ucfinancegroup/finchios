//
//  RecurringSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import SwiftUI

struct RecurringSummaryView: View {
    
    @ObservedObject var model: RecurringSummaryViewModel = RecurringSummaryViewModel()
    
    var body: some View {
        VStack {
            Text("Holder")
        }
    }
}

struct RecurringSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        RecurringSummaryView()
    }
}
