//
//  LeaderboardResponse.swift
//  finchios
//
//  Created by Andy Phan on 3/20/21.
//

import Foundation
import OpenAPIClient

public extension LeaderboardResponse {
    
    static let dummy: LeaderboardResponse = LeaderboardResponse(leaderboardType: "Savings", description: "Savings Leaderboard", percentile: 50.0);
    
}
