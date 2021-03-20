//
//  LeaderboardItemView.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import SwiftUI
import OpenAPIClient

struct LeaderboardItemView: View {
    
    var board: LeaderboardResponse
    
    var body: some View {
        VStack {
            Text(board.leaderboardType)
            Text(String(format: "%.1f", 100-board.percentile)).foregroundColor(.green)
        }
    }
}

//struct LeaderboardItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        LeaderboardItemView(board: LeaderboardResponse.dummy)
//    }
//}
