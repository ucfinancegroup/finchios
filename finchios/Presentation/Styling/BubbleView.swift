//
//  BubbleView.swift
//  finchios
//
//  Created by Brett Fazio on 1/24/21.
//

import Foundation
import SwiftUI

extension View {
    
    func bubble(_ color: Color) -> some View {
        self.background(color)
        .cornerRadius(20)
        .shadow(radius: 4)
        .padding()
    }
    
    func bubble() -> some View {
        self.bubble(.white)
    }
    
}
