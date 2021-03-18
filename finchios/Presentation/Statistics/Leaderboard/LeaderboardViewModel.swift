//
//  LeaderboardSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation
import OpenAPIClient
import os

class LeaderboardViewModel: ObservableObject, Identifiable {
    
    @Published var boards: [LeaderboardResponse] = []
    @Published var board_type: String = "Savings"
    
    func onAppear() {
        
        boards = []
        
        for board_type in ["Savings", "Spending", "Income"] {
            LeaderboardService.leaderboard(type: board_type) { (success, error, result) in
                DispatchQueue.main.async {
                    if success {
                        if let result = result {
                            self.boards.append(result)
                        }
                    } else {
                        //ERROR
                    }
                }
            }
        }
    }
}
