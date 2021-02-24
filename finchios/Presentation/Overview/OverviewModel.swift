//
//  OverviewModel.swift
//  finchios
//
//  Created by Brett Fazio on 2/22/21.
//

import Foundation
import OpenAPIClient

public class OverviewModel: ObservableObject, Identifiable {
    
    @Published public var insights: [Iden<Insight>] = []
    
    private var insightsGen: Bool = false
    
    public func onAppear() {
        self.fetchInsights()
    }
    
    private func fetchInsights() {
        if insightsGen {
            return
        }
        insightsGen = true
        
        // Fetch Insights
        InsightsService.insights { (success, _, result) in
            DispatchQueue.main.async {
                if let result = result {
                    print(result)
                    let nonDismissed = result.filter { !$0.dismissed }
                    self.insights = nonDismissed.enumerated().map { Iden<Insight>(obj: $1, index: $0) }
                }
            }
        }
    }
    
}
