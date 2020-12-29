//
//  LeaderboardService.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation

struct LeaderboardResponse: Codable {
    var leaderboard_type: String
    var percentile: Double
}
