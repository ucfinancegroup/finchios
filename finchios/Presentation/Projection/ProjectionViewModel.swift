//
//  ProjectionViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/17/20.
//

import Foundation
import OpenAPIClient

public class ProjectionViewModel: ObservableObject, Identifiable {

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
        InsightsService.example { (success, _, result) in
            DispatchQueue.main.async {
                if let result = result {
                    self.insights = result.enumerated().map { Iden<Insight>(obj: $1, index: $0) }
                }
            }
        }
    }
    
}
