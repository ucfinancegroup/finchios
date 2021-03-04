//
//  AllocationSliderView.swift
//  finchios
//
//  Created by Brett Fazio on 3/4/21.
//

import SwiftUI
import OpenAPIClient

struct AllocationSliderView: View {
    
    @Binding var value: Double
    
    @Binding var selection: AssetClass
    
    @Binding var classTypes: [Iden<AssetClass>]
    
    var body: some View {
        VStack {
            HStack {
                
                Menu {
                    ForEach(classTypes, id: \.id) { c in
                        Button(action: {
                            self.selection = c.obj
                        }, label: {
                            Text(c.obj.content)
                        })
                    }
                } label: {
                    Text(selection.content)
                }
                Slider(value: $value, in: 0...100, step: 1)
                
                Text("\(Int(value))")
                
                Button(action: {
                    
                }, label: {
                    Image(uiImage: UIImage(named: "TrashClear")!.withTintColor(.red))
                })
                .foregroundColor(.red)
                

                
                
            }
            .padding()
        }
    }
}

struct AllocationSliderViewPreview: View {
    
    @State var value: Double = 0.0
    @State var aClass = AssetClass.init(typ: .equity, content: "Equity")
    @State var classes = [
        Iden<AssetClass>(obj: AssetClass.init(typ: .equity, content: "Equity")),
        Iden<AssetClass>(obj: AssetClass.init(typ: .cash, content: "Cash"))]
    
    var body: some View {
        AllocationSliderView(value: $value, selection: $aClass, classTypes: $classes)
    }
    
}

struct AllocationSliderView_Previews: PreviewProvider {
    static var previews: some View {
        AllocationSliderViewPreview()
    }
}
