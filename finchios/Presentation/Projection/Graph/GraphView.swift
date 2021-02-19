//
//  GraphView.swift
//  finchios
//
//  Created by Brett Fazio on 12/19/20.
//

import SwiftUI
import Charts

struct GraphView: View {
    
    @StateObject private var model: GraphViewModel = GraphViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("$\(model.selected.y.format())")
                    .font(.largeTitle)
                    .padding([.leading, .trailing, .top])
                Text(model.formatDate(timeSince1970: model.selected.x))
                    .font(.title3)
                    .padding([.leading, .trailing, .bottom])
            }
                

            
            LineView(entries: model.timeseries, entry: $model.selected, today: $model.today)
        }
        .frame(height: 300)
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
