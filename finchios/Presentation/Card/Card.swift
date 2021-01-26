//
//  CardStack.swift
//  finchios
//
//  Created by Brett Fazio on 1/24/21.
//

import SwiftUI
import OpenAPIClient

public struct Card: View {
    
    @State private var translation: CGSize = .zero
    
    @Binding private var insight: Iden<Insight>// = Iden<Insight>(obj: .empty)
    private var onRemove: (_ text: Iden<Insight>) -> Void// = { _ in }
    
    private var thresholdPercentage: CGFloat = 0.5
    
    public init(input: Binding<Iden<Insight>>, onRemove: @escaping (_ text: Iden<Insight>) -> Void) {
        self.onRemove = onRemove
        _insight = input
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                
                HStack {
                    Spacer()
                    Text(insight.obj.title)
                    Spacer()
                }

            }
            .frame(height: 150, alignment: .center)
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: self.translation.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                    }.onEnded { value in
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                            self.onRemove(self.insight)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
        }

    }
}

struct CardPreview: View {
    
    @State var insight = Iden<Insight>(obj: .dummy)
    
    var body: some View {
        Card(input: $insight, onRemove: { _ in })
    }
    
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        CardPreview()
    }
}
