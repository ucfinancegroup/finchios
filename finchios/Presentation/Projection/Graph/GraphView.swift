//
//  GraphView.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import SwiftUI
import Charts

struct GraphView: View {
    
    @ObservedObject var model: GraphViewModel = GraphViewModel()
    
    var body: some View {
        VStack {
            LineView(entries: model.timeseries)
        }
        .frame(height: 300)
        .bubble()
        .onAppear() {
            model.onAppear()
        }
        
    }
}


// TODO(): reason why this view is hard to be a previewprovider
// is that all views should just have a binding provided if possible.
// here the binding should be passed model.timeseries instead of
// creating a model itself.
struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
