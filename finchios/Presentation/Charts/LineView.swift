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
    
    @Binding var entry: ChartDataEntry
    
    @Binding var today: ChartDataEntry
    
    private let view: LineChartView = LineChartView()
    
    class Coordinator: NSObject, ChartViewDelegate, UIGestureRecognizerDelegate {
        
        var parent: LineView
        
        public var reset: Bool = false
        
        init(_ parent: LineView) {
            self.parent = parent
        }
        
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            parent.entry = entry
        }
        
        func chartView(_ chartView: ChartViewBase, animatorDidStop animator: Animator) {
            parent.entry = parent.today
        }
        
        @objc func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        @objc func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
            if recognizer.state == .ended {
                parent.view.highlightValue(nil, callDelegate: false)
                parent.entry = parent.today
            }
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> LineChartView {
        view.drawGridBackgroundEnabled = false
        
        view.legend.enabled = false
        
        view.xAxis.enabled = false
        view.rightAxis.enabled = false
        view.leftAxis.enabled = false
        
        view.dragEnabled = true
        
        //view.xAxis.drawGridLinesEnabled = false
        view.leftAxis.drawGridLinesEnabled = false
    
        view.delegate = context.coordinator
        
        view.doubleTapToZoomEnabled = false
        
        let unselectGestureRecognizer = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.panGestureRecognized(_:)))
        unselectGestureRecognizer.delegate = context.coordinator

        view.addGestureRecognizer(unselectGestureRecognizer)
        
        view.isUserInteractionEnabled = true
        
        view.data = addData()
        return view
    }
    
    func addData() -> LineChartData {
        let data = LineChartData()
        let dataset = LineChartDataSet(entries: entries)
        
        let gradColors = [Color.teal.cgColor! , Color.white.cgColor!] as CFArray
        let loc: [CGFloat] = [1.0, 0]
        
        
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradColors, locations: loc) else {
            return data
        }
    
        
        dataset.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        dataset.drawFilledEnabled = true
        
        dataset.circleRadius = 0
        dataset.drawValuesEnabled = false
        
        dataset.drawHorizontalHighlightIndicatorEnabled = false
        
        dataset.highlightColor = UIColor.teal
        
        data.addDataSet(dataset)
        
        return data
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = addData()
    }
}

struct LineViewWrapper: View {
    
    @State var entry = ChartDataEntry(x: 0, y: 0)
    @State var today = ChartDataEntry(x: 0, y: 0)
    
    var body: some View {
        LineView(entries:[
            ChartDataEntry(x: 0, y: 10),
            ChartDataEntry(x: 1, y: 5),
            ChartDataEntry(x: 2, y: 0),
            ChartDataEntry(x: 3, y: 0),
            ChartDataEntry(x: 4, y: 100),
            ChartDataEntry(x: 5, y: 200),
        ], entry: $entry, today: $today)
    }
    
}

struct LineViewPreview: PreviewProvider {
    static var previews: some View {
        LineViewWrapper()
    }
}
