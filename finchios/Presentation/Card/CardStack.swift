//
//  CardStack.swift
//  finchios
//
//  Created by Brett Fazio on 1/24/21.
//

import SwiftUI
import OpenAPIClient

struct CardStack: View {
    
    @Binding var insights: [Iden<Insight>]
    
    private func getCardOffset(id: Int) -> CGFloat {
        return  CGFloat(insights.count - 1 - id) * 10
    }
    
    var body: some View {
        if insights.count > 0 {
            VStack {
                
                ZStack(alignment: .topTrailing) {
                    ForEach(self.insights, id: \.id) { insight in
                        Card(input: insight, onRemove: { removed in
                            // Remove that user from our array
                            self.insights.removeAll { $0.id == removed.id }
                        })
                            .animation(.spring()) // Animate our changes to our frame
                            .offset(x: 0, y: self.getCardOffset(id: insight.index))
                        
                    }
                }
                
            }
            .frame(height: 150, alignment: .center)
            .padding()
        }
        else {
            VStack {
                HStack {
                    Spacer()
                    Text("No new insights 🥳")
                    Spacer()
                }
                
            }
            .frame(height: 150, alignment: .center)
            .bubble()
        }
        
        
    }
}

struct CardStackPreview: View {
    
    @State var insights = [Iden<Insight>(obj: .dummy), Iden<Insight>(obj: .dummy)]
    
    var body: some View {
        CardStack(insights: $insights)
    }
    
}

struct CardStack_Previews: PreviewProvider {
    static var previews: some View {
        CardStackPreview()
    }
}
