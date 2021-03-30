//
//  LeaderboardItemView.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import SwiftUI
import OpenAPIClient

struct LeaderboardItemView: View {
    
    @Binding var board: Ranking
    
    var body: some View {
        let color: Color = board.percentile < 50 ? .red : .green
        VStack {
            HStack {
                Text(board.leaderboardType.rawValue).font(.largeTitle)
                Spacer()
            }
            HStack {
                Text("You're in the ")
                Text(String(format: "%.1fth", board.percentile))
                    .foregroundColor(color)
                Text("percentile")
                Spacer()
            }
        }
    }
}

struct LeaderboardItemView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardItemView(board: .constant(Ranking.dummy))
            .padding()
    }
}
