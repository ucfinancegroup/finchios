//
//  LeaderboardSummaryView.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation

class LeaderboardViewModel: ObservableObject, Identifiable {
    
    @Published var boards: [LeaderboardResponse] = []
    
}
