//
//  CardStack.swift
//  finchios
//
//  Created by Brett Fazio on 1/24/21.
//

import SwiftUI
import OpenAPIClient

struct CardStack: View {
    
    @State var insights: [Iden<Insight>]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                if insights.count > 0 {
                    VStack {
                        
                        ZStack {
                            ForEach(self.insights, id: \.id) { insight in
                                Card(input: insight, onRemove: { removed in
                                    // Remove that user from our array
                                    self.insights.removeAll { $0.id == removed.id }
                                })
                                .animation(.spring()) // Animate our changes to our frame
                            }
                        }
                        
                    }
                    
                    
                    VStack(alignment: .trailing) {
                        Text("\(insights.count)")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.teal)
                            .cornerRadius(200)
                    }
                }
                else {
                    
                    Text("No new insights 🥳")
                        .frame(width: 200, height: 150, alignment: .center)
                        .padding()
                        .background(Color(.systemGray))
                        .cornerRadius(5)
                    
                }
                
            }
            
        }
        .frame(width: 200, height: 150, alignment: .center)
        .padding()
    }
}

struct CardStack_Previews: PreviewProvider {
    static var previews: some View {
        CardStack(insights: [Iden<Insight>(obj: .empty), Iden<Insight>(obj: .empty)])
    }
}
