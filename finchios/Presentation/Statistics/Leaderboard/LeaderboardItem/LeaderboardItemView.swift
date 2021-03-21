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
        VStack {
            Text(board.leaderboardType)
            Text("\(board.percentile)")
        }
    }
}

//struct LeaderboardItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        LeaderboardItemView(board: Binding<LeaderboardResponse>)
//    }
//}
