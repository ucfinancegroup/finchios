//
//  LeaderboardSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation
import OpenAPIClient

class LeaderboardViewModel: ObservableObject, Identifiable {
    
    @Published var boards: [Iden<Ranking>] = []
    
    func onAppear() {
        
        boards = []
        
        for board_type in BoardTypes.allCases {
            LeaderboardService.leaderboard(type: board_type) { (success, error, result) in
                DispatchQueue.main.async {
                    if success {
                        if let result = result {
                            self.boards.append(Iden(obj: result))
                        }
                    } else {
                        //ERROR
                    }
                }
            }
        }
    }
}
