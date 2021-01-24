//
//  BubbleView.swift
//  finchios
//
//  Created by Brett Fazio on 1/24/21.
//

import Foundation
import SwiftUI

extension View {
    
    func bubble() -> some View {
        self.background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 4)
        .padding()
    }
    
}
