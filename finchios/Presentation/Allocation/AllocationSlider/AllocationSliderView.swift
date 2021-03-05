//
//  AllocationSliderView.swift
//  finchios
//
//  Created by Brett Fazio on 3/4/21.
//

import SwiftUI
import OpenAPIClient

struct AllocationSliderView: View {
    
    @Binding var value: Iden<Double>
    
    @Binding var selection: Iden<AssetClassAndApy>
    
    @Binding var classTypes: [Iden<AssetClassAndApy>]
    
    var model: AllocationSliderProtocol
    
    var body: some View {
        VStack {
            HStack {
                
                Menu {
                    ForEach(classTypes, id: \.id) { c in
                        Button(action: {
                            self.selection.obj = c.obj
                        }, label: {
                            Text(c.obj._class.typ.rawValue)
                        })
                    }
                } label: {
                    Text(selection.obj._class.typ.rawValue)
                }
                
                Slider(value: $value.obj, in: 0...100, step: 1)
                
                Text("\(Int(value.obj))")
                
                Button(action: {
                    model.delete(c: selection.id, amount: value.id)
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
    
    @StateObject var model = NewAllocationModel()
    
    @State var value: Iden<Double> = Iden<Double>(obj: 0)
    @State var aClass = Iden<AssetClassAndApy>(obj: AssetClassAndApy(_class: AssetClass.init(typ: .equity, content: "Equity"), apy: 5))
    @State var classes = [
        Iden<AssetClassAndApy>(obj: AssetClassAndApy(_class: AssetClass.init(typ: .equity, content: "Equity"), apy: 5)),
        Iden<AssetClassAndApy>(obj: AssetClassAndApy(_class: AssetClass.init(typ: .cash, content: "Cash"), apy: 5))]
    
    var body: some View {
        AllocationSliderView(value: $value, selection: $aClass, classTypes: $classes, model: model)
    }
    
}

struct AllocationSliderView_Previews: PreviewProvider {
    static var previews: some View {
        AllocationSliderViewPreview()
    }
}
