//
//  GraphView.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import SwiftUI

struct GraphView: View {
    
    @ObservedObject var model: GraphViewModel = GraphViewModel()
    
    var body: some View {
        
        VStack {
            LineView(entries: model.timeseries)
        }
        .frame(height: 300)
        .onAppear() {
            model.onAppear()
        }
        
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
