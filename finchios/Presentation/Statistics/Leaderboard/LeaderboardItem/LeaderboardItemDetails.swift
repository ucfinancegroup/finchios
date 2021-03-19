//
//  LeaderboardItemDetails.swift
//  finchios
//
//  Created by Andy Phan on 3/19/21.
//

import SwiftUI
import OpenAPIClient

struct LeaderboardItemDetailsView: View {
    
    var board: LeaderboardResponse
    
    var body: some View {
        VStack {
            Text(board.leaderboardType)
            Text("\nTop\n")
            Text("\(board.percentile)\n")
            Text("of All Users!")
        }
    }
}
