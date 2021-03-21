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
                Text(board.leaderboardType).font(.title)
                Spacer()
            }
            HStack {
                Text("Top")
                Text(String(format: "%.1f%%", 100-board.percentile))
                    .foregroundColor(color)
                Text("of Users")
                Spacer()
            }
        }
    }
}

struct LeaderboardItemView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardItemView(board: .constant(Ranking.dummy))
    }
}
