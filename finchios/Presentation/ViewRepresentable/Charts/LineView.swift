//
//  LineView.swift
//  finchios
//
//  Created by Brett Fazio on 12/18/20.
//

import Charts
import SwiftUI

struct LineView: UIViewRepresentable {
    typealias UIViewType = LineChartView
    
    var entries: [ChartDataEntry]

    func makeUIView(context: Context) -> LineChartView {
        let view = LineChartView()
    
        
        view.data = addData()
        return view
    }
    
    func addData() -> LineChartData {
        let data = LineChartData()
        let dataset = LineChartDataSet(entries: entries)
        
        data.addDataSet(dataset)
        
        return data
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        
    }
}

struct LineViewPreview: PreviewProvider {
    static var previews: some View {
        LineView(entries: [
            ChartDataEntry(x: 0, y: 10),
            ChartDataEntry(x: 1, y: 5),
            ChartDataEntry(x: 2, y: 0),
            ChartDataEntry(x: 3, y: 0),
            ChartDataEntry(x: 4, y: 100),
            ChartDataEntry(x: 5, y: 200),
        ])
    }
}
