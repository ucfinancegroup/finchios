//
//  LeaderboardItemDetails.swift
//  finchios
//
//  Created by Andy Phan on 3/19/21.
//

import SwiftUI
import OpenAPIClient

struct LeaderboardItemDetailsView: View {
    
    @Binding var board: Ranking
    
    var body: some View {
        VStack {
            Text("You are in the top").font(.title)
            
            let color: Color = board.percentile < 50 ? .red : .green
            
            Text(String(format: "%.1f%%", 100-board.percentile)).foregroundColor(color)
                .font(.system(size: 25))
            Text("of Similar Users").font(.title)
            Text("by \(board.leaderboardType.rawValue.capitalized)!").font(.title)
            ZStack {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .opacity(0.3)
                    .foregroundColor(Color.teal)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(board.percentile/100.0))
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.teal)
                    .rotationEffect(Angle(degrees: 270))
            }
            .padding()
            Spacer()
        }
        .navigationTitle(Text(board.leaderboardType.rawValue))
    }
}

struct LeaderboardItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardItemDetailsView(board: .constant(Ranking.dummy));
    }
}
