//
//  AllocationSliderView.swift
//  finchios
//
//  Created by Brett Fazio on 3/4/21.
//

import SwiftUI

struct AllocationSliderView: View {
    var body: some View {
        VStack {
            HStack {
                
                Button {
                    
                } label: {
                    Image(uiImage: UIImage(named: "TrashClear")!.withTintColor(.red))
                }
                
            }
        }
    }
}

struct AllocationSliderView_Previews: PreviewProvider {
    static var previews: some View {
        AllocationSliderView()
    }
}
