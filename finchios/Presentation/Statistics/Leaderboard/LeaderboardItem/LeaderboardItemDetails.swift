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
            Text("You are in the top").font(.system(size: 25))
            Text(String(format: "%.1f%%", 100-board.percentile)).foregroundColor(.green)
                .font(.system(size: 25))
            Text("of Similar Users").font(.system(size: 25))
            Text("by \(board.leaderboardType)!").font(.system(size: 25))
            ZStack {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .opacity(0.3)
                    .frame(width:200)
                    .foregroundColor(Color.teal)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(board.percentile/100.0))
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .frame(width:200)
                    .foregroundColor(Color.teal)
                    .rotationEffect(Angle(degrees: 270))
            }
            Spacer()
        }
        .navigationTitle(Text(board.leaderboardType))
    }
}

struct LeaderboardItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardItemDetailsView(board: LeaderboardResponse.dummy);
    }
}
