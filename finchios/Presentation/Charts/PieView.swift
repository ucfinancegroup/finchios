//
//  PieView.swift
//  finchios
//
//  Created by Brett Fazio on 12/18/20.
//

import Charts
import SwiftUI

struct PieView: UIViewRepresentable {
    typealias UIViewType = PieChartView
    
    var entries: [PieChartDataEntry]

    func makeUIView(context: Context) -> PieChartView {
        let view = PieChartView()
        view.data = addData()
        return view
    }
    
    func addData() -> PieChartData {
        let data = PieChartData()
        let dataset = PieChartDataSet(entries: entries)
        
        dataset.colors = [.red, .blue, .green, .purple, .orange]
        
        data.addDataSet(dataset)
        
        return data
    }
    
    func updateUIView(_ uiView: PieChartView, context: Context) {
        uiView.data = addData()
    }
}

struct PieViewPreview: PreviewProvider {
    static var previews: some View {
        PieView(entries: [
            PieChartDataEntry(value: 5, label: "five"),
            PieChartDataEntry(value: 10, label: "ten")
        ])
    }
}
