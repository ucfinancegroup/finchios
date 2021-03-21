//
//  LeaderboardResponse.swift
//  finchios
//
//  Created by Andy Phan on 3/20/21.
//

import Foundation
import OpenAPIClient

public extension Ranking {
    
    static let dummy: Ranking = Ranking(leaderboardType: "Savings", description: "Savings Leaderboard", percentile: 50.0);
    
}
