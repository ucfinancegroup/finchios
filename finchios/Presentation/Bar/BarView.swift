//
//  BarView.swift
//  finchios
//
//  Created by Brett Fazio on 2/7/21.
//

import SwiftUI

struct BarView: View {
    
    @Binding var percent: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(width: 200, height: 30)
                .foregroundColor(.lightGray)
            Capsule()
                .frame(width: CGFloat(max(100, percent*100))/100*200, height: 30)
                .foregroundColor(Color.teal)
        }
    }
}

struct BarViewPreview: View {
    
    @State var percent: Double = 0.75
    
    var body: some View {
        BarView(percent: $percent)
    }
    
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarViewPreview()
    }
}
