//
//  ProgressView.swift
//  finchios
//
//  Created by Brett Fazio on 2/6/21.
//

import Charts
import SwiftUI

struct ProgressView: UIViewRepresentable {
    typealias UIViewType = HorizontalBarChartView
    
    var entry: BarChartDataEntry
    
    private let view: HorizontalBarChartView = HorizontalBarChartView()
    
    class Coordinator: NSObject, ChartViewDelegate {
        
        var parent: ProgressView
        
        public var reset: Bool = false
        
        init(_ parent: ProgressView) {
            self.parent = parent
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> HorizontalBarChartView {
        view.drawGridBackgroundEnabled = false
        
        view.legend.enabled = false
        
        view.xAxis.enabled = false
        view.leftAxis.enabled = false
        
        view.dragEnabled = true
        
        view.xAxis.drawGridLinesEnabled = false
        view.leftAxis.drawGridLinesEnabled = false
    
        view.delegate = context.coordinator
        
        view.doubleTapToZoomEnabled = false
        
        view.data = addData()
        return view
    }
    
    func addData() -> BarChartData {
        let data = BarChartData()
        let dataset = BarChartDataSet(entries: [entry])
        
        dataset.highlightColor = UIColor.teal
        
        data.addDataSet(dataset)
        
        return data
    }
    
    func updateUIView(_ uiView: HorizontalBarChartView, context: Context) {
        uiView.data = addData()
    }
}

struct ProgressViewWrapper: View {
    
    @State var entry = ChartDataEntry(x: 0, y: 0)
    
    var body: some View {
        ProgressView(entry: BarChartDataEntry(x: 10, y: 20))
    }
    
}

struct ProgressViewPreview: PreviewProvider {
    static var previews: some View {
        ProgressViewWrapper()
    }
}
