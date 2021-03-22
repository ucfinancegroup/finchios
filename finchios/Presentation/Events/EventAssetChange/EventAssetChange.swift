//
//  EventAssetChange.swift
//  finchios
//
//  Created by Brett Fazio on 3/18/21.
//

import SwiftUI
import OpenAPIClient

struct EventAssetChange: View {
    
    @State var c: AssetClass
    @State var change: Double
    
    var body: some View {
        HStack {
            
            Text(c.typ.rawValue)
                .font(.title3)
            
            Spacer()
            
            Text("\(change.format())%")
                .font(.title2)
                .foregroundColor(getColorForChange(change: change))
            
        }
        .padding()
    }
    
    func getColorForChange(change: Double) -> Color {
        if change > 0 {
            return .green
        }
        else if change < 0 {
            return .red
        }
        
        return .black
    }
}

struct EventAssetChange_Previews: PreviewProvider {
    static var previews: some View {
        EventAssetChange(c: .init(typ: .cash), change: 50)
    }
}
